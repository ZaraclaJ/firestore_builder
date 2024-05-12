import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/easy_gen/reference_extensions.dart';
import 'package:firestore_builder/src/generators/generate_reference_service.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/generated_file.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

List<GeneratedFile> generateStreamService({
  required YamlConfig config,
}) {
  return [
    GeneratedFile(
      library: _streamServiceLibrary(
        config: config,
      ),
      filePath: config.streamServiceClass.path,
    ),
  ];
}

Library _streamServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.addAll([
        if (config.useRiverpod) _streamServiceProvider(config: config),
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
      ..assignment = RiverpodTypes.provider
          .autoDisposeFamilyMethod(
            state: streamServiceReference,
            parameters: [refVarName],
            body: streamServiceReference
                .call([], {
                  config.referenceServiceClass.field.toParameter.publicName:
                      const Reference(refVarName).watch(config.referenceServiceClass.providerReference.withoutUrl),
                })
                .returned
                .statement,
          )
          .code,
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
          ...config.allCollections.expand(
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

extension StreamServiceCollectionExtensions on Collection {
  Reference get _referenceServiceInstanceReference => configLight.referenceServiceClass.fieldReference;

  String get _collectionReferenceMethodName => collectionReferenceMethod.name!;
  List<Parameter> get _collectionReferenceMethodParameters => collectionReferenceMethod.optionalParameters.asList();

  String get _documentReferenceMethodName => documentReferenceMethod.name!;
  List<Parameter> get _documentReferenceMethodParameters => documentReferenceMethod.optionalParameters.asList();

  Method get collectionStreamMethod {
    final modelRef = modelReference;

    const eventVarName = 'event';
    const snapshotVarName = 'snapshot';

    final parameters = _collectionReferenceMethodParameters;

    return Method(
      (m) {
        m
          ..name = collectionStreamMethodName
          ..returns = BasicTypes.streamOf(BasicTypes.listOf(modelRef))
          ..optionalParameters.addAll(parameters)
          ..body = _referenceServiceInstanceReference.method(
            _collectionReferenceMethodName,
            namedArguments: {
              for (final parameter in parameters) parameter.name: Reference(parameter.name),
            },
          ).returnSnapshotsMapDocs(
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

    final parameters = _collectionReferenceMethodParameters;

    return Method(
      (m) {
        m
          ..name = collectionWhereStreamMethodName
          ..returns = BasicTypes.streamOf(BasicTypes.listOf(modelRef))
          ..optionalParameters.addAll([
            ...parameters,
            whereFunctionParameter,
          ])
          ..body = Block.of([
            declareFinal(collectionVarName)
                .assign(
                  _referenceServiceInstanceReference.method(
                    _collectionReferenceMethodName,
                    namedArguments: {
                      for (final parameter in parameters) parameter.name: Reference(parameter.name),
                    },
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
          ..optionalParameters.addAll(_documentReferenceMethodParameters)
          ..body = _referenceServiceInstanceReference
              .method(
                _documentReferenceMethodName,
                namedArguments: {
                  for (final parameter in _documentReferenceMethodParameters) parameter.name: Reference(parameter.name),
                },
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
