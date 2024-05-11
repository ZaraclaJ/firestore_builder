import 'package:firestore_builder/src/generators/generators.dart';
import 'package:firestore_builder/src/helpers/public_constants.dart';

void main(List<String> args) {
  switch (args) {
    case [final configFilePath]:
      generate(
        configFilePath: configFilePath,
      );
    case []:
      generate(
        configFilePath: defaultConfigFilPath,
      );

    default:
      throw Exception('''
Unknown command: $args.

Possible usages are :
`dart run firebase_builder`
`dart run firebase_builder path/to/your/config.yaml`
''');
  }
}
