import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/generators/generate_models.dart';
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
    filePath: config.referenceServiceClass.path,
  );
}

Library _referenceServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.addAll([
        _firestoreProvider(config: config),
        _referenceServiceProvider(config: config),
        _referenceServiceClass(config: config),
      ]);
    },
  ).buildLibrary();
}

Field _firestoreProvider({
  required YamlConfig config,
}) {
  return Field(
    (f) => f
      ..name = config.firestoreProviderName
      ..modifier = FieldModifier.final$
      ..assignment = RiverpodTypes.provider.autoDisposeMethod(
        typeArguments: [
          FirestoreTypes.firebaseFirestore,
        ],
        parameters: ['ref'],
        body: FirestoreTypes.firebaseFirestore.property('instance').returned.statement,
      ).code,
  );
}

Field _referenceServiceProvider({
  required YamlConfig config,
}) {
  const refVarName = 'ref';
  final referenceServiceReference = config.referenceServiceClass.reference.withoutUrl;

  return Field(
    (f) => f
      ..name = config.referenceServiceClass.providerName
      ..modifier = FieldModifier.final$
      ..assignment = RiverpodTypes.provider.autoDisposeMethod(
        typeArguments: [
          referenceServiceReference,
        ],
        parameters: [refVarName],
        body: referenceServiceReference
            .call([], {
              _firestoreInstanceField.toParameter.publicName:
                  const Reference(refVarName).watch(config.firestoreProviderReference.withoutUrl),
            })
            .returned
            .statement,
      ).code,
  );
}

Class _referenceServiceClass({
  required YamlConfig config,
}) {
  return Class(
    (c) {
      c
        ..name = config.referenceServiceClass.className
        ..fields.add(_firestoreInstanceField)
        ..methods.addAll([
          ...config.allCollections.expand(
            (c) => [
              c.collectionReferenceMethod,
              c.documentReferenceMethod,
            ],
          ),
        ]);
    },
  );
}

Field get _firestoreInstanceField {
  return Field(
    (f) => f
      ..name = firestoreInstanceName
      ..modifier = FieldModifier.final$
      ..type = FirestoreTypes.firebaseFirestore,
  );
}

extension on Collection {
  Method get collectionReferenceMethod {
    final modelRef = modelReference;

    const valueVarName = 'value';
    const snapshotVarName = 'snapshot';
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
                  fromFirestore: Expressions.lambdaMethod(
                    parameters: [snapshotVarName, '_'],
                    body: modelRef
                        .method(
                          fromFirestoreFactory.name!,
                          positionalArguments: [const Reference(snapshotVarName)],
                        )
                        .returned
                        .statement,
                    lambda: false,
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
