import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
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
        );
    },
  );
}
