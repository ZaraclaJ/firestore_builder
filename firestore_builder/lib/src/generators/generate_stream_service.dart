import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateStreamService({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _streamServiceLibrary(
      config: config,
    ),
    filePath: config.streamServiceClass.path,
  );
}

Library _streamServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.addAll([
        _streamServiceProvider(config: config),
        _streamServiceClass(
          config: config,
        ),
      ]);
    },
  ).buildLibrary();
}

Field _streamServiceProvider({
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
              config.referenceServiceClass.field.toParameter.publicName:
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
          config.referenceServiceClass.field,
        )
        ..methods.addAll([
          ...config.collections.expand(
            (c) => [
              c.collectionStreamMethod,
              c.collectionWhereStreamMethod,
              c.documentStreamMethod,
            ],
          ),
        ]);
    },
  );
}

extension on Collection {
  Parameter get _idParameter => Parameter(
        (p) => p
          ..name = 'id'
          ..type = modelIdReference,
      );

  Reference get _referenceServiceInstanceReference => configLight.referenceServiceClass.fieldReference;

  Method get collectionStreamMethod {
    final modelRef = modelReference;

    const eventVarName = 'event';
    const snapshotVarName = 'snapshot';

    return Method(
      (m) {
        m
          ..name = collectionStreamMethodName
          ..returns = BasicTypes.streamOf(BasicTypes.listOf(modelRef))
          ..body = _referenceServiceInstanceReference.method(collectionReferenceMethodName).returnSnapshotsMapDocs(
                eventVarName: eventVarName,
                snapshotVarName: snapshotVarName,
              );
      },
    );
  }

  Method get collectionWhereStreamMethod {
    final modelRef = modelReference;

    const collectionVarName = 'collection';
    const eventVarName = 'event';
    const snapshotVarName = 'snapshot';
    final whereFunctionParameter = this.whereFunctionParameter;

    return Method(
      (m) {
        m
          ..name = collectionWhereStreamMethodName
          ..returns = BasicTypes.streamOf(BasicTypes.listOf(modelRef))
          ..optionalParameters.add(whereFunctionParameter)
          ..body = Block.of([
            declareFinal(collectionVarName)
                .assign(
                  _referenceServiceInstanceReference.method(
                    collectionReferenceMethodName,
                  ),
                )
                .statement,
            Reference(whereFunctionParameter.name).call(
              [const Reference(collectionVarName)],
            ).returnSnapshotsMapDocs(
              eventVarName: eventVarName,
              snapshotVarName: snapshotVarName,
            ),
          ]);
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
          ..body = _referenceServiceInstanceReference
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

extension on Expression {
  Code returnSnapshotsMapDocs({
    required String eventVarName,
    required String snapshotVarName,
  }) {
    return method(FirestoreSymbols.snapshotsMethod)
        .map(
          parameters: [eventVarName],
          body: Reference(eventVarName)
              .property(FirestoreSymbols.docsProperty)
              .map(
                parameters: [snapshotVarName],
                body: Reference(snapshotVarName).method(FirestoreSymbols.dataMethod).code,
              )
              .toList()
              .code,
        )
        .returned
        .statement;
  }
}
