import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:meta/meta.dart';
import 'package:recase/recase.dart';

extension FreezedLibraryExtensions on Library {
  @UseResult()
  Library toFreezed({
    required bool withJson,
    required String fileName,
  }) {
    return rebuild(
      (libraryBuilder) => libraryBuilder
        ..directives.addAll([
          Directive.part('$fileName.freezed.dart'),
          if (withJson) Directive.part('$fileName.g.dart'),
        ])
        ..body.map((spec) {
          if (spec is Class) {
            return spec.toFreezed(
              withJson: withJson,
            );
          }
          return spec;
        }),
    );
  }
}

extension FreezedClassExtensions on Class {
  @UseResult()
  Class toFreezed({
    required bool withJson,
  }) {
    return rebuild(
      (c) {
        final fields = c.fields.build().asList();
        return c
          ..sealed = constructors.every((c) => c.name != null)
          ..annotations.add(
            BasicAnnotations.freezed(
              toJson: withJson,
              fromJson: withJson,
            ),
          )
          ..mixins.add(Reference(r'_$' + name))
          ..constructors.map(
            (ctor) => ctor.rebuild(
              (ctor) {
                final constructorName = ctor.name;

                return ctor
                  ..factory = true
                  ..redirect = Reference(
                    [
                      if (constructorName == null) '_',
                      name.pascalCase,
                      if (constructorName != null) constructorName.pascalCase,
                    ].join(),
                  )
                  ..optionalParameters.map((p) {
                    final associatedField = fields.firstWhereOrNull(
                      (f) => f.name == p.name,
                    );
                    final fieldType = associatedField?.type;
                    final fieldAnnotations = associatedField?.annotations;

                    p = p.rebuild(
                      (p) => p
                        ..toThis = false
                        ..type = fieldType
                        ..annotations.addAll(fieldAnnotations ?? []),
                    );

                    final defaultValue = p.defaultTo;
                    if (defaultValue != null && defaultValue is ToCodeExpression) {
                      return p.rebuild(
                        (p) => p
                          ..defaultTo = null
                          ..annotations.add(
                            BasicAnnotations.defaultFreezed(
                              defaultValue.code,
                            ),
                          ),
                      );
                    }
                    return p;
                  });
              },
            ),
          )
          ..constructors.sort(_sortByName)
          ..constructors.addAll([
            if (withJson)
              Constructor(
                (jsonCtor) => jsonCtor
                  ..factory = true
                  ..name = 'fromJson'
                  ..requiredParameters.add(
                    Parameter(
                      (p) => p
                        ..name = 'json'
                        ..type = const Reference('Map<String, dynamic>'),
                    ),
                  )
                  ..lambda = true
                  ..body = Code(
                    '_\$${name}FromJson(json)',
                  ),
              ),
            if (methods.isNotEmpty)
              Constructor(
                (p0) => p0
                  ..constant = true
                  ..name = '_',
              ),
          ])
          ..fields.removeWhere((f) => !f.static);
      },
    );
  }

  int _sortByName(Constructor a, Constructor b) {
    final aName = a.name;
    final bName = b.name;
    if (aName == null) {
      return -1;
    } else if (bName == null) {
      return 1;
    } else {
      return aName.compareTo(bName);
    }
  }
}
