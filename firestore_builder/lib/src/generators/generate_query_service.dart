import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/code_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/models/collection.dart';
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
      ..assignment = RiverpodTypes.provider.autoDisposeMethod(
        typeArguments: [
          queryServiceReference,
        ],
        parameters: [refVarName],
        body: queryServiceReference
            .call([], {
              config.referenceServiceClass.field.toParameter.publicName:
                  const Reference(refVarName).watch(config.referenceServiceClass.providerReference),
            })
            .returned
            .statement,
      ).code,
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
          ...config.collections.expand(
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
  final reference = config.updatedValueFieldReference;
  final fieldName = config.updatedValueFieldName;
  return Class(
    (c) {
      c
        ..name = config.updatedValueClassName
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

  Parameter get modelIdParam => Parameter(
        (p) => p
          ..name = modelIdReference.symbol!.camelCase
          ..type = modelIdReference,
      );

  Method get getDocumentMethod {
    final modelIdParam = this.modelIdParam;
    const resultVarName = 'result';

    return Method(
      (m) {
        m
          ..name = getDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(modelReference.nullSafe)
          ..requiredParameters.add(modelIdParam)
          ..body = Block.of([
            declareFinal(resultVarName)
                .assign(
                  _referenceServiceInstanceReference.awaited.method(
                    documentReferenceMethodName,
                    positionalArguments: [Reference(modelIdParam.name)],
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
          ..body = Block.of([
            declareFinal(resultVarName)
                .assign(
                  _referenceServiceInstanceReference.awaited
                      .method(
                        collectionReferenceMethodName,
                      )
                      .method(
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
    const whereParameterName = FirestoreSymbols.whereMethod;

    return Method(
      (m) {
        m
          ..name = getCollectionWhereMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.listOf(modelReference))
          ..optionalParameters.add(
            Parameter(
              (p) => p
                ..named = true
                ..required = true
                ..name = whereParameterName
                ..type = FunctionType((f) {
                  f
                    ..returnType = FirestoreTypes.queryOf(modelReference)
                    ..requiredParameters.add(
                      FirestoreTypes.collectionReferenceOf(modelReference),
                    );
                }),
            ),
          )
          ..body = Block.of([
            declareFinal(collectionVarName)
                .assign(
                  _referenceServiceInstanceReference.method(
                    collectionReferenceMethodName,
                  ),
                )
                .statement,
            declareFinal(resultVarName)
                .assign(
                  const Reference(whereParameterName).awaited.call(
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
          ..requiredParameters.add(
            Parameter(
              (p) => p
                ..name = modelVarName
                ..type = modelRef,
            ),
          )
          ..body = Block.of([
            declareFinal(resultVarName)
                .assign(
                  _referenceServiceInstanceReference.awaited
                      .method(
                    collectionReferenceMethodName,
                  )
                      .method(
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
          ..requiredParameters.add(
            Parameter(
              (p) => p
                ..name = modelVarName
                ..type = modelRef,
            ),
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
              documentReferenceMethodName,
              positionalArguments: [Reference(idVarName)],
            ).method(
              FirestoreSymbols.setMethod,
              positionalArguments: [Reference(modelVarName)],
            ).statement,
          ]);
      },
    );
  }

  Method get updateDocumentMethod {
    final modelIdParam = this.modelIdParam;
    const dataVarName = 'data';

    final parameters = fields.map(
      (f) => f.parameter().toUpdatedValueParam(configLight.updatedValueClassName),
    );

    return Method(
      (m) {
        m
          ..name = updateDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.void$)
          ..optionalParameters.addAll([
            modelIdParam.toRequired,
            ...parameters,
          ])
          ..body = Block.of([
            declareFinal(dataVarName)
                .assign(
                  literalMap({
                    for (final item in fields)
                      modelReference.property(item.staticKeyField().name).code.ifBlock(
                            Code('${item.parameter().name} != null'),
                            withBrackets: false,
                          ): Reference(item.parameter().name).property(configLight.updatedValueFieldName),
                  }),
                )
                .statement,
            const Reference('').returned.statement.ifBlock(const Reference(dataVarName).isEmpty.code),
            _referenceServiceInstanceReference.awaited.method(
              documentReferenceMethodName,
              positionalArguments: [Reference(modelIdParam.name)],
            ).method(
              FirestoreSymbols.updateMethod,
              positionalArguments: [const Reference(dataVarName)],
            ).statement,
          ]);
      },
    );
  }

  Method get deleteDocumentMethod {
    final modelIdParam = this.modelIdParam;

    return Method(
      (m) {
        m
          ..name = deleteDocumentMethodName
          ..modifier = MethodModifier.async
          ..returns = BasicTypes.futureOf(BasicTypes.void$)
          ..requiredParameters.add(modelIdParam)
          ..body = _referenceServiceInstanceReference.awaited
              .method(
                documentReferenceMethodName,
                positionalArguments: [Reference(modelIdParam.name)],
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
