import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:firestore_builder/src/easy_gen/freezed_extensions.dart';
import 'package:firestore_builder/src/extensions.dart/bool_extensions.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:meta/meta.dart';

extension LibraryExtensions on Library {
  @UseResult()
  Library buildLibrary({
    required bool toFreezed,
    required bool withJson,
    required String fileName,
  }) {
    return rebuild(
      (libraryBuilder) => libraryBuilder
        ..directives.addAll([
          if (toFreezed) Directive.part('$fileName.freezed.dart'),
          if (toFreezed && withJson) Directive.part('$fileName.g.dart'),
        ])
        ..body.map((spec) {
          if (spec is Class) {
            var class$ = spec;

            if (class$.constructors.whereNot((c) => c.factory).isEmpty) {
              class$ = class$.buildClassConstructor();
            }

            if (toFreezed) {
              class$ = class$.toFreezed(
                withJson: withJson,
              );
            }

            return class$;
          }
          return spec;
        }),
    );
  }
}

extension ClassExtensions on Class {
  @UseResult()
  Class buildClassConstructor({
    bool optional = true,
  }) {
    final parameters = fields
        .asList()
        .whereNot(
          (element) => element.static,
        )
        .map(
          (e) => e.toParameter.toThisParameter,
        )
        .sort();
    return rebuild(
      (c) => c
        ..constructors.add(
          Constructor(
            (ctor) => ctor
              ..constant = true
              ..optionalParameters.addAll(
                [
                  if (optional) ...parameters,
                ],
              )
              ..requiredParameters.addAll(
                [
                  if (!optional)
                    ...parameters.map(
                      (e) => e.rebuild((p) => p.required = false),
                    ),
                ],
              ),
          ),
        )
        ..fields.map(
          (f) {
            if (f.static) {
              return f;
            }
            return f.rebuild(
              (f) => f.assignment = null,
            );
          },
        ),
    );
  }
}

extension ParameterExtensions on Parameter {
  @UseResult()
  Parameter get toThisParameter {
    return rebuild(
      (parameterBuilder) => parameterBuilder
        ..toThis = true
        ..type = null,
    );
  }
}

extension ParameterListExtensions on Iterable<Parameter> {
  List<Parameter> sort() {
    return sorted(
      (a, b) => a.required.compareTo(b.required),
    );
  }
}

extension FieldExtensions on Field {
  @UseResult()
  Parameter get toParameter {
    final isNullable = type?.isNullable ?? false;
    final defaultValue = assignment;
    return Parameter(
      (parameterBuilder) {
        parameterBuilder
          ..name = name
          ..type = type
          ..required = defaultValue == null && !isNullable
          ..named = true
          ..defaultTo = assignment;
      },
    );
  }
}

extension ReferenceExtensions on Reference {
  bool get isNullable {
    final reference = this;
    final typeNullable = reference is TypeReference && (reference.isNullable ?? false);
    final symbolNullable = reference.symbol?.isNullable ?? false;
    return typeNullable || symbolNullable;
  }
}
