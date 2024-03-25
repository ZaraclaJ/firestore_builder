import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/code_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/generators/generate_reference_service.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';

Future<void> generateQueryService({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _queryServiceLibrary(
      config: config,
    ),
    filePath: config.queryServiceClass.path,
  );
}

Library _queryServiceLibrary({
  required YamlConfig config,
}) {
  return Library(
    (library) {
      library.body.addAll([
        _queryServiceProvider(config: config),
        _queryServiceClass(config: config),
        _updatedValueClass(config: config),
      ]);
    },
  ).buildLibrary();
}

Field _queryServiceProvider({
  required YamlConfig config,
}) {
  const refVarName = 'ref';
  final queryServiceReference = config.queryServiceClass.reference.withoutUrl;

  return Field(
    (f) => f
      ..name = config.queryServiceClass.providerName
      ..modifier = FieldModifier.final$
      ..assignment = RiverpodTypes.provider
          .autoDisposeFamilyMethod(
            state: queryServiceReference,
            parameters: [refVarName],
            body: queryServiceReference
                .call([], {
                  config.referenceServiceClass.field.toParameter.publicName:
                      const Reference(refVarName).watch(config.referenceServiceClass.providerReference),
                })
                .returned
                .statement,
          )
          .code,
  );
}

Class _queryServiceClass({
  required YamlConfig config,
}) {
  return Class(
    (c) {
      c
        ..name = config.queryServiceClass.className
        ..fields.add(
          config.referenceServiceClass.field,
        )
        ..methods.addAll([
          ...config.allCollections.expand(
            (c) => [
              c.getCollectionMethod,
              c.getCollectionWhereMethod,
              c.getDocumentMethod,
              c.addDocumentMethod,
              c.setDocumentMethod,
              c.updateDocumentMethod,
              c.deleteDocumentMethod,
            ],
          ),
        ]);
    },
  );
}

Class _updatedValueClass({
  required YamlConfig config,
}) {
  const reference = BasicTypes.generic;
  const fieldName = UpdatedValueSymbols.valueProperty;
  return Class(
    (c) {
      c
        ..name = UpdatedValueSymbols.updatedValueClass
        ..types.add(reference)
        ..constructors.add(
          Constructor(
            (c) => c
              ..constant = true
              ..requiredParameters.add(
                Parameter(
                  (p) => p
                    ..name = fieldName
                    ..type = reference,
                ).inConstructor,
              ),
          ),
        )
        ..fields.add(
          Field(
            (f) => f
              ..name = fieldName
              ..modifier = FieldModifier.final$
              ..type = reference,
          ),
        );
    },
  );
}

extension on Collection {
  Reference get _referenceServiceInstanceReference => configLight.referenceServiceClass.fieldReference;

  String get _collectionReferenceMethodName => collectionReferenceMethod.name!;
  List<Parameter> get _collectionReferenceMethodParameters => collectionReferenceMethod.optionalParameters.asList();

  String get _documentReferenceMethodName => documentReferenceMethod.name!;
  List<Parameter> get _documentReferenceMethodParameters => documentReferenceMethod.optionalParameters.asList();

  Method get getDocumentMethod {
    const resultVarName = 'result';

    return Method(
      (m) {
        m
          ..name = getDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(modelReference.nullSafe)
          ..optionalParameters.addAll(_documentReferenceMethodParameters)
          ..body = Block.of([
            declareFinal(resultVarName)
                .assign(
                  _referenceServiceInstanceReference.awaited.method(
                    _documentReferenceMethodName,
                    namedArguments: {
                      for (final parameter in _documentReferenceMethodParameters)
                        parameter.name: Reference(parameter.name),
                    },
                  ).method(
                    FirestoreSymbols.getMethod,
                  ),
                )
                .statement,
            const Reference(resultVarName).method(FirestoreSymbols.dataMethod).returned.statement,
          ]);
      },
    );
  }

  Method get getCollectionMethod {
    const resultVarName = 'result';
    const snapshotVarName = 'snapshot';

    return Method(
      (m) {
        m
          ..name = getCollectionMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.listOf(modelReference))
          ..optionalParameters.addAll(_collectionReferenceMethodParameters)
          ..body = Block.of([
            declareFinal(resultVarName)
                .assign(
                  _referenceServiceInstanceReference.awaited.method(
                    _collectionReferenceMethodName,
                    namedArguments: {
                      for (final parameter in _collectionReferenceMethodParameters)
                        parameter.name: Reference(parameter.name),
                    },
                  ).method(
                    FirestoreSymbols.getMethod,
                  ),
                )
                .statement,
            _returnDocsResult(
              resultVarName: resultVarName,
              snapshotVarName: snapshotVarName,
            ),
          ]);
      },
    );
  }

  Method get getCollectionWhereMethod {
    const collectionVarName = 'collection';
    const resultVarName = 'result';
    const snapshotVarName = 'snapshot';
    final whereFunctionParameter = this.whereFunctionParameter;

    return Method(
      (m) {
        m
          ..name = getCollectionWhereMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.listOf(modelReference))
          ..optionalParameters.addAll([
            ..._collectionReferenceMethodParameters,
            whereFunctionParameter,
          ])
          ..body = Block.of([
            declareFinal(collectionVarName)
                .assign(
                  _referenceServiceInstanceReference.method(
                    _collectionReferenceMethodName,
                    namedArguments: {
                      for (final parameter in _collectionReferenceMethodParameters)
                        parameter.name: Reference(parameter.name),
                    },
                  ),
                )
                .statement,
            declareFinal(resultVarName)
                .assign(
                  Reference(whereFunctionParameter.name).awaited.call(
                    [const Reference(collectionVarName)],
                  ).method(
                    FirestoreSymbols.getMethod,
                  ),
                )
                .statement,
            _returnDocsResult(
              resultVarName: resultVarName,
              snapshotVarName: snapshotVarName,
            ),
          ]);
      },
    );
  }

  Code _returnDocsResult({
    required String resultVarName,
    required String snapshotVarName,
  }) {
    return Reference(resultVarName)
        .property(FirestoreSymbols.docsProperty)
        .map(
          parameters: [snapshotVarName],
          body: Reference(snapshotVarName).method(FirestoreSymbols.dataMethod).code,
        )
        .toList()
        .returned
        .statement;
  }

  Method get addDocumentMethod {
    final modelRef = modelReference;
    final modelVarName = modelRef.symbol!.camelCase;
    const resultVarName = 'result';

    return Method(
      (m) {
        m
          ..name = addDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.string)
          ..optionalParameters.addAll([
            ..._collectionReferenceMethodParameters,
            Parameter(
              (p) => p
                ..name = modelVarName
                ..type = modelRef,
            ).toRequired,
          ])
          ..body = Block.of([
            declareFinal(resultVarName)
                .assign(
                  _referenceServiceInstanceReference.awaited.method(
                    _collectionReferenceMethodName,
                    namedArguments: {
                      for (final parameter in _collectionReferenceMethodParameters)
                        parameter.name: Reference(parameter.name),
                    },
                  ).method(
                    FirestoreSymbols.addMethod,
                    positionalArguments: [Reference(modelVarName)],
                  ),
                )
                .statement,
            const Reference(resultVarName).property(FirestoreSymbols.idProperty).returned.statement,
          ]);
      },
    );
  }

  Method get setDocumentMethod {
    final modelRef = modelReference;
    final modelVarName = modelRef.symbol!.camelCase;
    final idVarName = modelIdReference.symbol!.camelCase;

    return Method(
      (m) {
        m
          ..name = setDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.void$)
          ..optionalParameters.addAll(
            [
              ..._documentReferenceMethodParameters,
              Parameter(
                (p) => p
                  ..name = modelVarName
                  ..type = modelRef,
              ).toRequired,
            ],
          )
          ..body = Block.of([
            declareFinal(idVarName).assign(Reference(modelVarName).property(modelIdFieldName)).statement,
            const Reference('assert').call(
              [
                Reference(idVarName).property(modelIdValueFieldName).isNotEmpty,
                literalString('$modelVarName must have a $idVarName: \$$modelVarName'),
              ],
            ).statement,
            _referenceServiceInstanceReference.awaited.method(
              _documentReferenceMethodName,
              namedArguments: {
                for (final parameter in _documentReferenceMethodParameters) parameter.name: Reference(parameter.name),
              },
            ).method(
              FirestoreSymbols.setMethod,
              positionalArguments: [Reference(modelVarName)],
            ).statement,
          ]);
      },
    );
  }

  Method get updateDocumentMethod {
    const dataVarName = 'data';

    const updatedClassName = UpdatedValueSymbols.updatedValueClass;

    final parameters = fields.map(
      (f) => f.parameter().toUpdatedValueParam(updatedClassName),
    );

    final firestoreFieldParameters = fields
        .map(
          (f) => f.firestoreFieldValue()?.toParameter.toUpdatedValueParam(updatedClassName),
        )
        .whereNotNull();

    return Method(
      (m) {
        m
          ..name = updateDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.void$)
          ..optionalParameters.addAll([
            ..._documentReferenceMethodParameters,
            ...parameters,
            ...firestoreFieldParameters,
          ])
          ..body = Block.of([
            declareFinal(dataVarName)
                .assign(
                  literalMap({
                    for (final item in fields)
                      item.dataKey(
                        modelReference: modelReference,
                        name: item.fieldName,
                      ): item.fieldDataValue(name: item.fieldName),
                    for (final item in fields.where((element) => element.acceptFieldValue))
                      item.dataKey(
                        modelReference: modelReference,
                        name: item.firestoreFieldValueName,
                      ): item.fieldDataValue(name: item.firestoreFieldValueName),
                  }),
                )
                .statement,
            const Reference('').returned.statement.ifBlock(const Reference(dataVarName).isEmpty.code),
            _referenceServiceInstanceReference.awaited.method(
              _documentReferenceMethodName,
              namedArguments: {
                for (final parameter in _documentReferenceMethodParameters) parameter.name: Reference(parameter.name),
              },
            ).method(
              FirestoreSymbols.updateMethod,
              positionalArguments: [const Reference(dataVarName)],
            ).statement,
          ]);
      },
    );
  }

  Method get deleteDocumentMethod {
    return Method(
      (m) {
        m
          ..name = deleteDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.void$)
          ..optionalParameters.addAll(_documentReferenceMethodParameters)
          ..body = _referenceServiceInstanceReference.awaited
              .method(
                _documentReferenceMethodName,
                namedArguments: {
                  for (final parameter in _documentReferenceMethodParameters) parameter.name: Reference(parameter.name),
                },
              )
              .method(
                FirestoreSymbols.deleteMethod,
              )
              .statement;
      },
    );
  }
}

extension on Parameter {
  Parameter toUpdatedValueParam(String updatedClassName) {
    return rebuild(
      (p) => p
        ..required = false
        ..type = TypeReference(
          (type) => type
            ..symbol = updatedClassName
            ..isNullable = true
            ..types.add(p.type!),
        ),
    );
  }
}

extension on CollectionField {
  Code dataKey({
    required Reference modelReference,
    required String name,
  }) {
    return modelReference.property(staticKeyField().name).code.ifBlock(
          Code('$name != null'),
          withBrackets: false,
        );
  }

  Expression fieldDataValue({
    required String name,
  }) {
    return Reference(name).property(UpdatedValueSymbols.valueProperty);
  }
}
