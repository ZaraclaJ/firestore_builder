import 'package:firestore_builder/src/generator_service.dart';
import 'package:test/test.dart';

const String _configFilePath = 'test/firestore_builder_config.yaml';

void main() {
  test(
    'generate',
    () async {
      await GeneratorService().generate(
        configFilePath: _configFilePath,
      );
    },
  );
}
