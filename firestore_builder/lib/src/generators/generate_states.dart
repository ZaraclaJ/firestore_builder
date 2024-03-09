import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateStates({
  required YamlConfig config,
}) async {
  final collections = config.collections;

  final futures = collections.map(
    (c) => generateLibrary(
      library: c.stateLibrary,
      filePath: c.stateFilePath,
    ),
  );

  await Future.wait(futures);
}

extension on Collection {
  Library get stateLibrary {
    return Library(
      (library) {
        library.body.addAll([
          _modelStreamProviderField,
          _modelProviderField,
          _collectionStreamProviderField,
          _collectionProviderField,
        ]);
      },
    );
  }

  Field get _modelStreamProviderField {
    const refVarName = 'ref';
    const idVarName = 'id';
    const serviceVarName = 'service';
    return Field(
      (f) {
        f
          ..name = modelStreamProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.streamProvider.autoDispose.familyMethod(
            typeArguments: [
              modelReference.nullSafe,
              modelIdReference,
            ],
            parameters: [refVarName, idVarName],
            body: Block.of([
              declareFinal(serviceVarName)
                  .assign(
                    const Reference(refVarName).watch(
                      yamlConfigLight.streamServiceProviderReference,
                    ),
                  )
                  .statement,
              const Reference(serviceVarName)
                  .method(documentStreamMethodName, positionalArguments: [const Reference(idVarName)])
                  .returned
                  .statement,
            ]),
          ).code;
      },
    );
  }

  Field get _modelProviderField {
    const refVarName = 'ref';
    const idVarName = 'id';
    const streamVarName = 'stream';
    return Field(
      (f) {
        f
          ..name = modelProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.provider.autoDispose.familyMethod(
            typeArguments: [
              modelReference.nullSafe,
              modelIdReference,
            ],
            parameters: [refVarName, idVarName],
            body: Block.of([
              declareFinal(streamVarName)
                  .assign(
                    const Reference(refVarName).watch(
                      Reference(_modelStreamProviderField.name).call([const Reference(idVarName)]),
                    ),
                  )
                  .statement,
              const Reference(streamVarName).property('value').returned.statement,
            ]),
          ).code;
      },
    );
  }

  Field get _collectionStreamProviderField {
    const refVarName = 'ref';
    const serviceVarName = 'service';
    return Field(
      (f) {
        f
          ..name = collectionStreamProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.streamProvider.autoDisposeMethod(
            typeArguments: [
              BasicTypes.listOf(modelReference),
            ],
            parameters: [refVarName],
            body: Block.of([
              declareFinal(serviceVarName)
                  .assign(
                    const Reference(refVarName).watch(
                      yamlConfigLight.streamServiceProviderReference,
                    ),
                  )
                  .statement,
              const Reference(serviceVarName).method(collectionStreamMethodName).returned.statement,
            ]),
          ).code;
      },
    );
  }

  Field get _collectionProviderField {
    const refVarName = 'ref';
    const streamVarName = 'stream';
    return Field(
      (f) {
        f
          ..name = collectionProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.provider.autoDisposeMethod(
            typeArguments: [
              BasicTypes.listOf(modelReference).nullSafe,
            ],
            parameters: [refVarName],
            body: Block.of([
              declareFinal(streamVarName)
                  .assign(
                    const Reference(refVarName).watch(
                      Reference(_collectionStreamProviderField.name),
                    ),
                  )
                  .statement,
              const Reference(streamVarName).property('value').returned.statement,
            ]),
          ).code;
      },
    );
  }
}
