import 'dart:io';

import 'package:firestore_builder/src/extensions.dart/map_entry_extensions.dart';
import 'package:firestore_builder/src/generators/clear_files.dart';
import 'package:firestore_builder/src/generators/generate_freezed_converters.dart';
import 'package:firestore_builder/src/generators/generate_models.dart';
import 'package:firestore_builder/src/generators/generate_query_service.dart';
import 'package:firestore_builder/src/generators/generate_reference_service.dart';
import 'package:firestore_builder/src/generators/generate_states.dart';
import 'package:firestore_builder/src/generators/generate_stream_service.dart';
import 'package:firestore_builder/src/generators/generate_updated_value.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:yaml/yaml.dart';

Future<void> generate({
  required String? configFilePath,
}) async {
  configFilePath ??= pubspecPath;
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

  if (!file.path.endsWith('.yaml')) {
    throw Exception('Unsupported file extension (not .yaml) : ${file.path}');
  }

  final config = await _parseConfigFileToGetYamlConfig(
    file: file,
  );

  if (config.clear) {
    await clearFiles(path: config.outputPath);
  }

  await Future.wait([
    generateFreezedConverters(config: config),
    generateModels(config: config),
    generateReferenceService(config: config),
    generateStreamService(config: config),
    generateStates(config: config),
    generateQueryService(config: config),
    generateUpdatedValue(config: config),
  ]);
}

Future<YamlConfig> _parseConfigFileToGetYamlConfig({
  required File file,
}) async {
  final yamlString = await file.readAsString();

  YamlMap yamlMap;
  try {
    yamlMap = loadYaml(yamlString) as YamlMap;
  } catch (e) {
    throw Exception('''
Error parsing the configuration file: ${file.path}, $e
''');
  }

  if (file.path != pubspecPath) {
    final pubspecFile = File(pubspecPath);
    final exist = pubspecFile.existsSync();
    if (!exist) {
      throw Exception('''
pubspec.yaml not found: $pubspecPath
''');
    }

    final pubspecYamlString = await pubspecFile.readAsString();

    YamlMap pubspecYamlMap;
    try {
      pubspecYamlMap = loadYaml(pubspecYamlString) as YamlMap;
    } catch (e) {
      throw Exception('''
Error parsing the pubspec.yaml file, $e
''');
    }

    yamlMap = YamlMap.wrap({
      ...yamlMap.entries.toMap(),
      ...pubspecYamlMap.entries.toMap(),
    });
  }

  return YamlConfig.fromYaml(
    yamlMap,
  );
}
