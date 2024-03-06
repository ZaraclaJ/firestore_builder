import 'package:firestore_builder/src/generators.dart';
import 'package:test/test.dart';

const String _outputFolderPath = 'test/output';
const String _configFilePath = 'test/firestore_builder_config.yaml';

void main() {
  test(
    'generate',
    () async {
      await generate(
        outputFolderPath: _outputFolderPath,
        configFilePath: _configFilePath,
      );
    },
  );
}
