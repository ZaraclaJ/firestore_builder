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
        configFilePath: defaultConfigFileName,
      );

    default:
      throw Exception('''
Unknown command: $args.

Possible usages are :
`dart run firestore_builder`
`dart run firestore_builder path/to/your/config.yaml`
''');
  }
}
