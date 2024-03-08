import 'package:firestore_builder/src/generators/generators.dart';
import 'package:test/test.dart';

const String _configFilePath = 'test/firestore_builder_config.yaml';

void main() {
  test(
    'generate',
    () async {
      await generate(
        configFilePath: _configFilePath,
      );
    },
  );
}
