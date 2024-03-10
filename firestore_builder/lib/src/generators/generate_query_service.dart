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
              c.addDocumentMethod,
              c.getDocumentMethod,
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
