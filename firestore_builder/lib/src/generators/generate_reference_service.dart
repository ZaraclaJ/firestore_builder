import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateReferenceService({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _referenceServiceLibrary(
      collections: config.collections,
    ),
    filePath: config.referenceServicePath,
  );
}

Library _referenceServiceLibrary({
  required List<Collection> collections,
}) {
  return Library(
    (library) {
      library.body.add(
        _referenceServiceClass(
          collections: collections,
        ),
      );
    },
  ).buildLibrary();
}

Class _referenceServiceClass({
  required List<Collection> collections,
}) {
  return Class(
    (c) {
      c
        ..name = firestoreReferenceServiceName
        ..fields.add(
          Field(
            (f) => f
              ..name = '_firestore'
              ..modifier = FieldModifier.final$
              ..type = FirestoreTypes.firebaseFirestore,
          ),
        );
    },
  );
}
