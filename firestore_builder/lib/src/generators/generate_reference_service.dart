import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

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
        ..name = config.referenceServiceClassName
        ..fields.add(
          Field(
            (f) => f
              ..name = firestoreInstanceName
              ..modifier = FieldModifier.final$
              ..type = FirestoreTypes.firebaseFirestore,
          ),
        )
        ..methods.addAll([
          ...config.collections.expand(
            (c) => [
              c.collectionReferenceMethod,
              c.documentReferenceMethod,
            ],
          ),
        ]);
    },
  );
}

extension on Collection {
  Method get collectionReferenceMethod {
    final modelRef = modelReference;

    const valueVarName = 'value';
    const fromFirestore = FirestoreSymbols.fromFirestoreParam;
    const toFirestore = FirestoreSymbols.toFirestoreParam;

    return Method(
      (m) {
        m
          ..name = collectionReferenceMethodName
          ..returns = FirestoreTypes.collectionReferenceOf(modelRef)
          ..body = const Reference(firestoreInstanceName)
              .method(
                FirestoreSymbols.collectionMethod,
                positionalArguments: [modelRef.property(collectionKeyName)],
              )
              .method(
                FirestoreSymbols.withConverterMethod,
                namedArguments: {
                  fromFirestore: modelRef.property(
                    fromFirestore,
                  ),
                  toFirestore: Expressions.lambdaMethod(
                    parameters: [valueVarName, '_'],
                    body: const Reference(valueVarName).method(toFirestore).returned.statement,
                    lambda: false,
                  ),
                },
              )
              .returned
              .statement;
      },
    );
  }

  Method get documentReferenceMethod {
    final modelRef = modelReference;
    const idVarName = 'id';

    return Method(
      (m) {
        m
          ..name = documentReferenceMethodName
          ..returns = FirestoreTypes.documentReferenceOf(modelRef)
          ..requiredParameters.add(
            Parameter(
              (p) => p
                ..name = idVarName
                ..type = modelIdReference,
            ),
          )
          ..body = Reference(collectionReferenceMethodName)
              .call([])
              .method(
                FirestoreSymbols.docMethod,
                positionalArguments: [const Reference(idVarName).property('value')],
              )
              .returned
              .statement;
      },
    );
  }
}
