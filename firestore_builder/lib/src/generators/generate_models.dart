import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';

Future<void> generateModels({
  required YamlConfig config,
}) {
  final modelsPath = config.modelsPath;
  final collections = config.collections;

  final futures = collections.map(
    (c) => generateLibrary(
      library: c.modelLibrary,
      filePath: '$modelsPath/${c.snakeName}.dart',
    ),
  );

  return Future.wait(futures);
}

extension CollectionExtensions on Collection {
  String get modelClassName => modelName.pascalCase;

  Library get modelLibrary {
    return Library(
      (library) {
        library.body.addAll([
          _modelClass,
          _idClass,
        ]);
      },
    ).buildLibrary(
      freezedConfig: FreezedConfig(
        fileName: snakeName,
        withJson: true,
      ),
    );
  }

  Class get _modelClass {
    return Class(
      (classBuilder) {
        classBuilder
          ..name = modelClassName
          ..constructors.add(
            _fromFirestoreFactory,
          )
          ..fields.addAll([
            ...fields.map(
              (collectionField) => collectionField.staticKeyField(),
            ),
            ...fields.map(
              (collectionField) => collectionField.field(
                className: modelClassName,
              ),
            ),
            _idField,
          ])
          ..methods.addAll([
            _idGetter,
            _toFirestoreMethod,
          ]);
      },
    );
  }

  Field get _idField {
    return Field(
      (field) {
        field
          ..name = databaseIdName
          ..type = BasicTypes.string
          ..assignment = literalString('').code
          ..modifier = FieldModifier.final$
          ..annotations.add(
            BasicAnnotations.jsonKey(
              includeFromJson: false,
              includeToJson: false,
            ),
          );
      },
    );
  }

  Method get _idGetter {
    final idClassRef = Reference(_idClass.name);
    return Method(
      (method) {
        method
          ..name = '${modelClassName.camelCase}Id'
          ..type = MethodType.getter
          ..returns = idClassRef
          ..lambda = true
          ..body = idClassRef.call([
            Reference(_idField.name),
          ]).code;
      },
    );
  }

  Constructor get _fromFirestoreFactory {
    const snapshotVarName = 'snapshot';
    const dataVarName = 'data';
    return Constructor(
      (ctor) {
        ctor
          ..factory = true
          ..name = fromFirestoreFactoryName
          ..requiredParameters.addAll([
            Parameter(
              (p) {
                p
                  ..name = snapshotVarName
                  ..type = FirestoreTypes.documentSnapshotOf(
                    BasicTypes.json,
                  );
              },
            ),
            Parameter(
              (p) {
                p
                  ..name = 'options'
                  ..type = FirestoreTypes.snapshotOptions(
                    isNullable: true,
                  );
              },
            ),
          ])
          ..body = Block.of([
            declareFinal(dataVarName)
                .assign(
                  const Reference(snapshotVarName).method('data'),
                )
                .statement,
            Reference(modelClassName)
                .method(
                  FreezedMethods.fromJson,
                  [const Reference(dataVarName).nullChecked],
                )
                .method(FreezedMethods.copyWith, [], {
                  _idField.name: const Reference(snapshotVarName).property('id'),
                })
                .returned
                .statement,
          ]);
      },
    );
  }

  Method get _toFirestoreMethod {
    const jsonVarName = 'json';

    return Method(
      (method) {
        method
          ..name = toFirestoreMethodName
          ..returns = BasicTypes.json
          ..body = Block.of([
            declareFinal(jsonVarName)
                .assign(
                  const Reference('toJson').call([]),
                )
                .statement,
            const Reference(jsonVarName).returned.statement,
          ]);
      },
    );
  }

  Class get _idClass {
    return Class(
      (classBuilder) {
        const fieldName = 'value';
        const fieldType = BasicTypes.string;

        classBuilder
          ..name = '${modelClassName}Id'
          ..fields.add(
            Field(
              (field) {
                field
                  ..name = fieldName
                  ..type = fieldType
                  ..modifier = FieldModifier.final$;
              },
            ),
          );
      },
    ).buildClassConstructor(optional: false);
  }
}