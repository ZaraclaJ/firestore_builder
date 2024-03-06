import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/extensions.dart/dart_formatter_extensions.dart';
import 'package:firestore_builder/src/helpers/logger.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:yaml/yaml.dart';

const String _defaultConfigPath = 'pubspec.yaml';

/// Generate Firestore Builder
Future<void> generate({
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

  YamlMap yamlMap;
  try {
    yamlMap = loadYaml(yaml) as YamlMap;
  } catch (e) {
    throw Exception('''
Error parsing the configuration file: $configFilePath, $e
''');
  }

  final firestoreBuilderConfig = yamlMap['firestore_builder'] as YamlMap?;
  if (firestoreBuilderConfig == null) {
    throw Exception('''
The configuration file ($configFilePath) does not contain a firestore_builder section
''');
  }
  final outputPath = firestoreBuilderConfig['output'] as String?;

  if (outputPath == null) {
    throw Exception('''
The configuration file ($configFilePath) does not contain an output section
''');
  }

  final collections = firestoreBuilderConfig['collections'];
  if (collections is! YamlList?) {
    throw Exception('''
The configuration file ($configFilePath) does not contain a correct collections section: $collections
''');
  }

  final collectionsNode = collections?.nodes
      .whereType<YamlMap>()
      .map(
        Collection.fromYaml,
      )
      .toList();

  Logger.log('outputPath: $outputPath');
  Logger.log('collections: $collections');
  Logger.log('collectionsNode: $collectionsNode');
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
