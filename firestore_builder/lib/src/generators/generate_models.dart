import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/code_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/easy_gen/reference_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateModels({
  required YamlConfig config,
}) async {
  final collections = config.allCollections;

  final futures = collections.map(
    (c) => generateLibrary(
      library: c.modelLibrary,
      filePath: c.modelFilePath,
    ),
  );

  await Future.wait(futures);
}

extension ModelCollectionExtensions on Collection {
  Library get modelLibrary {
    return Library(
      (library) {
        library.body.addAll([
          _modelClass,
          _idClass,
          if (collectionPath.isNotEmpty) _pathClass,
        ]);
      },
    ).buildLibrary(
      freezedConfig: FreezedConfig(
        fileName: modelFileName,
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
            fromFirestoreFactory,
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
            ...fields
                .map(
                  (collectionField) => collectionField.firestoreFieldValue(),
                )
                .whereNotNull(),
            _idField,
          ])
          ..methods.addAll([
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
          ..name = modelIdFieldName
          ..type = modelIdReference.withoutUrl
          ..assignment = modelIdReference.withoutUrl.call([literalString('')]).code
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

  Constructor get fromFirestoreFactory {
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
                  positionalArguments: [const Reference(dataVarName).nullChecked],
                )
                .method(
                  FreezedSymbols.copyWithMethod,
                  namedArguments: {
                    _idField.name: _idField.type!.call([const Reference(snapshotVarName).property('id')]),
                  },
                )
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
            ...fields.where((element) => element.acceptFieldValue).map(
              (field) {
                final firestoreFieldValueName = field.firestoreFieldValueName;
                return Code('$jsonVarName[${field.keyVarName}] = $firestoreFieldValueName;').ifBlock(
                  Code('$firestoreFieldValueName != null'),
                );
              },
            ),
            const Reference(jsonVarName).returned.statement,
          ]);
      },
    );
  }

  Class get _idClass {
    return Class(
      (classBuilder) {
        classBuilder
          ..name = modelIdClassName
          ..fields.add(
            Field(
              (field) {
                field
                  ..name = modelIdValueFieldName
                  ..type = BasicTypes.string
                  ..modifier = FieldModifier.final$;
              },
            ),
          );
      },
    ).buildClassConstructor(optional: false);
  }

  Class get _pathClass {
    return Class(
      (classBuilder) {
        classBuilder
          ..name = modelPathClassName
          ..fields.add(
            _pathIdField(withImport: false),
          )
          ..fields.addAll(
            collectionPath.map(
              (c) => c._pathIdField(withImport: true),
            ),
          );
      },
    ).buildClassConstructor();
  }

  Field _pathIdField({
    required bool withImport,
  }) {
    return Field(
      (field) {
        field
          ..name = modelIdFieldName
          ..type = withImport ? modelIdReference : modelIdReference.withoutUrl
          ..modifier = FieldModifier.final$;
      },
    );
  }
}
