import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
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
        _queryServiceClass(
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
            ],
          ),
        ]);
    },
  );
}

extension on Collection {
  Reference get _referenceServiceInstanceReference => configLight.referenceServiceClass.fieldReference;

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
}
