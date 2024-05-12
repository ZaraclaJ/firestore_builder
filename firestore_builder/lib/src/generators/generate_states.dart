import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/easy_gen/reference_extensions.dart';
import 'package:firestore_builder/src/generators/generate_stream_service.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/generated_file.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

List<GeneratedFile> generateStates({
  required YamlConfig config,
}) {
  if (!config.useRiverpod) {
    return [];
  }

  final collections = config.allCollections;

  return collections
      .map(
        (c) => GeneratedFile(
          library: c.stateLibrary,
          filePath: c.stateFilePath,
        ),
      )
      .toList();
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
    const serviceVarName = 'service';

    final documentFamilyParameter = this.documentFamilyParameter;
    final idVarName = documentFamilyParameter.name;
    final documentStreamMethod = this.documentStreamMethod;

    return Field(
      (f) {
        f
          ..name = modelStreamProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.streamProvider
              .autoDisposeFamilyMethod(
                state: modelReference.nullSafe,
                arg: documentFamilyParameter.type,
                parameters: [refVarName, idVarName],
                body: Block.of([
                  declareFinal(serviceVarName)
                      .assign(
                        const Reference(refVarName).watch(
                          configLight.streamServiceClass.providerReference,
                        ),
                      )
                      .statement,
                  const Reference(serviceVarName)
                      .method(
                        documentStreamMethod.name!,
                        namedArguments: {
                          for (final parameterName in documentStreamMethod.optionalParameters.map((p) => p.name))
                            parameterName: idVarName == parameterName
                                ? Reference(idVarName)
                                : Reference(idVarName).property(parameterName),
                        },
                      )
                      .returned
                      .statement,
                ]),
              )
              .code;
      },
    );
  }

  Field get _modelProviderField {
    const refVarName = 'ref';
    const streamVarName = 'stream';

    final documentFamilyParameter = this.documentFamilyParameter;
    final idVarName = documentFamilyParameter.name;
    return Field(
      (f) {
        f
          ..name = modelProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.provider
              .autoDisposeFamilyMethod(
                state: modelReference.nullSafe,
                arg: documentFamilyParameter.type,
                parameters: [refVarName, idVarName],
                body: Block.of([
                  declareFinal(streamVarName)
                      .assign(
                        const Reference(refVarName).watch(
                          Reference(_modelStreamProviderField.name).call([Reference(idVarName)]),
                        ),
                      )
                      .statement,
                  const Reference(streamVarName).property('value').returned.statement,
                ]),
              )
              .code;
      },
    );
  }

  Field get _collectionStreamProviderField {
    const refVarName = 'ref';
    const serviceVarName = 'service';

    final collectionFamilyParameter = this.collectionFamilyParameter;
    final idVarName = collectionFamilyParameter?.name;

    final collectionStreamMethod = this.collectionStreamMethod;

    return Field(
      (f) {
        f
          ..name = collectionStreamProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.streamProvider
              .autoDisposeFamilyMethod(
                state: BasicTypes.listOf(modelReference),
                arg: collectionFamilyParameter?.type,
                parameters: [
                  refVarName,
                  if (idVarName != null) idVarName,
                ],
                body: Block.of([
                  declareFinal(serviceVarName)
                      .assign(
                        const Reference(refVarName).watch(
                          configLight.streamServiceClass.providerReference,
                        ),
                      )
                      .statement,
                  const Reference(serviceVarName)
                      .method(
                        collectionStreamMethod.name!,
                        namedArguments: {
                          for (final parameterName in collectionStreamMethod.optionalParameters.map((p0) => p0.name))
                            parameterName: idVarName == parameterName
                                ? Reference(idVarName)
                                : Reference(idVarName).property(parameterName),
                        },
                      )
                      .returned
                      .statement,
                ]),
              )
              .code;
      },
    );
  }

  Field get _collectionProviderField {
    const refVarName = 'ref';
    const streamVarName = 'stream';

    final collectionFamilyParameter = this.collectionFamilyParameter;
    final idVarName = collectionFamilyParameter?.name;

    return Field(
      (f) {
        f
          ..name = collectionProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.provider
              .autoDisposeFamilyMethod(
                state: BasicTypes.listOf(modelReference).nullSafe,
                arg: collectionFamilyParameter?.type,
                parameters: [
                  refVarName,
                  if (idVarName != null) idVarName,
                ],
                body: Block.of([
                  declareFinal(streamVarName)
                      .assign(
                        const Reference(refVarName).watch(
                          idVarName == null
                              ? Reference(_collectionStreamProviderField.name)
                              : Reference(_collectionStreamProviderField.name).call([Reference(idVarName)]),
                        ),
                      )
                      .statement,
                  const Reference(streamVarName).property('value').returned.statement,
                ]),
              )
              .code;
      },
    );
  }
}
