import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';

Future<void> generateReferenceService({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _referenceServiceLibrary(
      config: config,
    ),
    filePath: config.referenceServicePath,
  );
}

Library _referenceServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.add(
        _referenceServiceClass(
          config: config,
        ),
      );
    },
  ).buildLibrary();
}

Class _referenceServiceClass({
  required YamlConfig config,
}) {
  return Class(
    (c) {
      c
        ..name = firestoreReferenceServiceName
        ..fields.add(
          Field(
            (f) => f
              ..name = firestoreInstanceName
              ..modifier = FieldModifier.final$
              ..type = FirestoreTypes.firebaseFirestore,
          ),
        )
        ..methods.addAll([
          ...config.collections.map(
            (collection) => _collectionReferenceMethod(
              config: config,
              collection: collection,
            ),
          ),
        ]);
    },
  );
}

Method _collectionReferenceMethod({
  required YamlConfig config,
  required Collection collection,
}) {
  final modelRef = Reference(
    collection.modelName.pascalCase,
    collection.modelFileUrl(config: config),
  );

  const valueVarName = 'value';
  const fromFirestore = FirestoreSymbols.fromFirestoreParam;
  const toFirestore = FirestoreSymbols.toFirestoreParam;

  return Method(
    (m) {
      m
        ..name = '${collection.name.camelCase}Collection'
        ..returns = FirestoreTypes.collectionReferenceOf(modelRef)
        ..body = const Reference(firestoreInstanceName)
            .method(
              FirestoreSymbols.collectionMethod,
              [modelRef.property(collectionKeyName)],
            )
            .method(FirestoreSymbols.withConverterMethod, [], {
              fromFirestore: modelRef.property(
                fromFirestore,
              ),
              toFirestore: Expressions.lambdaMethod(
                parameters: [valueVarName, '_'],
                body: const Reference(valueVarName).method(toFirestore).returned.statement,
                lambda: false,
              ),
            })
            .returned
            .statement;
    },
  );
}
