import 'package:firestore_builder/src/generators.dart';

void main(List<String> args) {
  switch (args) {
    case [final outputFolderPath, final configFilePath]:
      generate(
        outputFolderPath: outputFolderPath,
        configFilePath: configFilePath,
      );
    case [final outputFolderPath]:
      generate(
        outputFolderPath: outputFolderPath,
        configFilePath: null,
      );

    default:
      throw Exception('''
Unknown command: $args.

Possible usages are :
`dart run firebase_builder output/folder/path`
`dart run firebase_builder output/folder/path path/to/your/config.yaml`
''');
  }
}
