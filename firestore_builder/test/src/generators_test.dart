import 'package:firestore_builder/src/generators.dart';
import 'package:test/test.dart';

const String _configPath = 'test/firestore_builder_config.yaml';

void main() {
  test(
    'generate',
    () async {
      await generate(
        path: _configPath,
      );
    },
  );
}
