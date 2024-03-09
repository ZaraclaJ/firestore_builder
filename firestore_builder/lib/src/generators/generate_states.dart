import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
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
          streamProviderField,
        ]);
      },
    );
  }

  Field get streamProviderField {
    const refVarName = 'ref';
    const idVarName = 'id';
    const serviceVarName = 'service';
    return Field(
      (f) {
        f
          ..name = streamProviderName
          ..modifier = FieldModifier.final$
          ..assignment = RiverpodTypes.streamProvider.autoDispose.method(
            RiverpodSymbols.family,
            typeArguments: [
              modelReference.nullSafe,
              modelIdReference,
            ],
            positionalArguments: [
              Expressions.lambdaMethod(
                lambda: false,
                parameters: [refVarName, idVarName],
                body: Block.of([
                  declareFinal(serviceVarName)
                      .assign(
                        const Reference(refVarName).watch(
                          Reference(yamlConfigLight.streamServiceProviderName),
                        ),
                      )
                      .statement,
                  const Reference(serviceVarName)
                      .method(documentStreamMethodName, positionalArguments: [const Reference(idVarName)])
                      .returned
                      .statement,
                ]),
              ),
            ],
          ).code;
      },
    );
  }
}
