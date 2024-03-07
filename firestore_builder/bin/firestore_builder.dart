import 'package:firestore_builder/src/generator_service.dart';

void main(List<String> args) {
  switch (args) {
    case [final configFilePath]:
      GeneratorService().generate(
        configFilePath: configFilePath,
      );
    case []:
      GeneratorService().generate(
        configFilePath: null,
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
