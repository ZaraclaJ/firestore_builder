import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateStreamService({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _streamServiceLibrary(
      config: config,
    ),
    filePath: config.streamServicePath,
  );
}

Library _streamServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.add(
        _streamServiceClass(
          config: config,
        ),
      );
    },
  ).buildLibrary();
}

Class _streamServiceClass({
  required YamlConfig config,
}) {
  return Class(
    (c) {
      c
        ..name = config.streamServiceClassName
        ..fields.add(
          Field(
            (f) => f
              ..name = referenceServiceInstanceName
              ..modifier = FieldModifier.final$
              ..type = config.referenceServiceReference,
          ),
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
          ..returns = BasicTypes.streamOf(BasicTypes.listOf(modelRef.nullSafe))
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
              .method(documentReferenceMethodName, [Reference(_idParameter.name)])
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
