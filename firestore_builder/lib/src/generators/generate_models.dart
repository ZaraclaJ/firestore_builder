import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
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
  final collections = config.collections;

  final futures = collections.map(
    (c) => generateLibrary(
      library: c.modelLibrary,
      filePath: c.modelFilePath,
    ),
  );

  return Future.wait(futures);
}

extension CollectionExtensions on Collection {
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
            _staticCollectionKeyField,
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

  Field get _staticCollectionKeyField {
    return Field(
      (field) {
        field
          ..static = true
          ..modifier = FieldModifier.constant
          ..type = BasicTypes.string
          ..name = collectionKeyName
          ..assignment = literalString(name).code;
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
          ..name = modelIdClassName.camelCase
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
          ..name = FirestoreSymbols.fromFirestoreParam
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
                  FreezedSymbols.fromJsonMethod,
                  [const Reference(dataVarName).nullChecked],
                )
                .method(FreezedSymbols.copyWithMethod, [], {
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
          ..name = FirestoreSymbols.toFirestoreParam
          ..returns = BasicTypes.json
          ..body = Block.of([
            declareFinal(jsonVarName)
                .assign(
                  const Reference(FreezedSymbols.toJsonMethod).call([]),
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
          ..name = modelIdClassName
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
