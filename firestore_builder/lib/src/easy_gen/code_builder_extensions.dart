import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:firestore_builder/src/easy_gen/freezed_extensions.dart';
import 'package:firestore_builder/src/extensions.dart/bool_extensions.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:meta/meta.dart';

class FreezedConfig {
  const FreezedConfig({
    required this.withJson,
    required this.fileName,
  });

  final bool withJson;
  final String fileName;
}

extension LibraryExtensions on Library {
  @UseResult()
  Library buildLibrary({
    FreezedConfig? freezedConfig,
  }) {
    return rebuild(
      (libraryBuilder) => libraryBuilder
        ..directives.addAll([
          if (freezedConfig != null) Directive.part('${freezedConfig.fileName}.freezed.dart'),
          if (freezedConfig != null && freezedConfig.withJson) Directive.part('${freezedConfig.fileName}.g.dart'),
        ])
        ..body.map((spec) {
          if (spec is Class) {
            var class$ = spec;

            if (class$.constructors.whereNot((c) => c.factory).isEmpty) {
              class$ = class$.buildClassConstructor();
            }

            if (freezedConfig != null) {
              class$ = class$.toFreezed(
                withJson: freezedConfig.withJson,
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
          (e) => e.toParameter,
        );

    final privateParameters = parameters.where(
      (p) => p.isPrivate,
    );

    final constructorParameters = parameters
        .map(
          (p) => p.inConstructor,
        )
        .sort();

    return rebuild(
      (c) => c
        ..constructors.add(
          Constructor(
            (ctor) => ctor
              ..constant = true
              ..initializers.addAll(
                privateParameters.map(
                  (p) {
                    return Reference(p.name)
                        .assign(
                          Reference(p.publicName),
                        )
                        .code;
                  },
                ),
              )
              ..optionalParameters.addAll(
                [
                  if (optional) ...constructorParameters,
                ],
              )
              ..requiredParameters.addAll(
                [
                  if (!optional)
                    ...constructorParameters.map(
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
  String get publicName => name.publicName;

  Parameter get toRequired {
    return rebuild(
      (p) => p
        ..required = true
        ..named = true,
    );
  }

  @UseResult()
  Parameter copyWithName(String name) {
    final parameter = this;
    return Parameter(
      (parameterBuilder) {
        parameterBuilder
          ..name = name
          ..type = parameter.type
          ..required = parameter.required
          ..named = parameter.named
          ..defaultTo = parameter.defaultTo;
      },
    );
  }

  @UseResult()
  Parameter get inConstructor {
    if (isPrivate) {
      return copyWithName(publicName);
    }

    return rebuild(
      (parameterBuilder) => parameterBuilder
        ..toThis = true
        ..type = null,
    );
  }

  bool get isPrivate => name.startsWith('_');
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
