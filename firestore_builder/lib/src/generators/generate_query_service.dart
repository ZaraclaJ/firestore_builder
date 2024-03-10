import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateQueryService({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _queryServiceLibrary(
      config: config,
    ),
    filePath: config.streamServiceClass.path,
  );
}

Library _queryServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.addAll([
        _queryServiceProvider(config: config),
        _streamServiceClass(
          config: config,
        ),
      ]);
    },
  ).buildLibrary();
}

Field _queryServiceProvider({
  required YamlConfig config,
}) {
  const refVarName = 'ref';
  final streamServiceReference = config.streamServiceClass.reference.withoutUrl;

  return Field(
    (f) => f
      ..name = config.streamServiceClass.providerName
      ..modifier = FieldModifier.final$
      ..assignment = RiverpodTypes.provider.autoDisposeMethod(
        typeArguments: [
          streamServiceReference,
        ],
        parameters: [refVarName],
        body: streamServiceReference
            .call([], {
              _firestoreInstanceField(config: config).toParameter.publicName:
                  const Reference(refVarName).watch(config.referenceServiceClass.providerReference.withoutUrl),
            })
            .returned
            .statement,
      ).code,
  );
}

Class _streamServiceClass({
  required YamlConfig config,
}) {
  return Class(
    (c) {
      c
        ..name = config.streamServiceClass.className
        ..fields.add(
          _firestoreInstanceField(config: config),
        )
        ..methods.addAll([
          ...config.collections.expand(
            (c) => [
              c.documentStreamMethod,
              c.collectionStreamMethod,
            ],
          ),
        ]);
    },
  );
}

Field _firestoreInstanceField({
  required YamlConfig config,
}) {
  return Field(
    (f) => f
      ..name = referenceServiceInstanceName
      ..modifier = FieldModifier.final$
      ..type = config.referenceServiceClass.reference,
  );
}

extension on Collection {
  Parameter get _idParameter => Parameter(
        (p) => p
          ..name = 'id'
          ..type = modelIdReference,
      );

  Method get collectionStreamMethod {
    final modelRef = modelReference;

    const eventVarName = 'event';
    const snapshotVarName = 'snapshot';

    return Method(
      (m) {
        m
          ..name = collectionStreamMethodName
          ..returns = BasicTypes.streamOf(BasicTypes.listOf(modelRef))
          ..body = const Reference(referenceServiceInstanceName)
              .method(collectionReferenceMethodName)
              .method(FirestoreSymbols.snapshotsMethod)
              .map(
                parameters: [eventVarName],
                body: const Reference(eventVarName)
                    .property(FirestoreSymbols.docsProperty)
                    .map(
                      parameters: [snapshotVarName],
                      body: const Reference(snapshotVarName).method(FirestoreSymbols.dataMethod).code,
                    )
                    .toList()
                    .code,
              )
              .returned
              .statement;
      },
    );
  }

  Method get documentStreamMethod {
    final modelRef = modelReference;
    const eventVarName = 'event';

    return Method(
      (m) {
        m
          ..name = documentStreamMethodName
          ..returns = BasicTypes.streamOf(modelRef.nullSafe)
          ..requiredParameters.add(_idParameter)
          ..body = const Reference(referenceServiceInstanceName)
              .method(
                documentReferenceMethodName,
                positionalArguments: [Reference(_idParameter.name)],
              )
              .method(FirestoreSymbols.snapshotsMethod)
              .map(
                parameters: [eventVarName],
                body: const Reference(eventVarName).method(FirestoreSymbols.dataMethod).code,
              )
              .returned
              .statement;
      },
    );
  }
}
