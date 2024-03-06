import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/extensions.dart/dart_formatter_extensions.dart';
import 'package:firestore_builder/src/helpers/logger.dart';
import 'package:yaml/yaml.dart';

const String _defaultConfigPath = 'firestore_builder_config.yaml';

/// Generate Firestore Builder
Future<void> generate({
  required String outputFolderPath,
  required String? configFilePath,
}) async {
  configFilePath ??= _defaultConfigPath;
  final file = File(configFilePath);
  final exist = file.existsSync();
  if (!exist) {
    throw Exception('''
File not found: $configFilePath
You should create a firestore_builder_config.yaml file in the root of your project
You can also indicate the path of your configuration file:
  dart run firestore_builder path/to/your/config.yaml
''');
  }

  await _analyzeConfigFile(
    configFilePath: configFilePath,
  );
}

Future<void> _analyzeConfigFile({
  required String configFilePath,
}) async {
  final file = File(configFilePath);
  if (!file.path.endsWith('.yaml')) {
    throw Exception('Unsupported file extension (not .yaml) : ${file.path}');
  }

  final yaml = await file.readAsString();

  try {
    final yamlMap = loadYaml(yaml) as YamlMap;
    Logger.log('yamlMap: $yamlMap');
  } catch (e) {
    throw Exception('''
Error parsing the configuration file: $configFilePath, $e
''');
  }
}

Future<File> _generateFakeFile({
  required String outputPath,
}) async {
  final fakeClass = Class((classBuilder) {
    classBuilder
      ..name = 'FakeClass'
      ..fields.add(
        Field((field) {
          field
            ..name = 'name'
            ..type = refer('String?');
        }),
      );
  });

  final result = Library(
    (library) {
      library.body.add(fakeClass);
    },
  );

  final dartLibrary = result.toDart();
  final file = File('$outputPath/fake_file.dart');
  await file.create(recursive: true);
  await file.writeAsString(dartLibrary);

  Logger.log('✔︎ Fake file generated');
  return file;
}
