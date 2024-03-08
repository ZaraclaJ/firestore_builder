import 'dart:io';

import 'package:firestore_builder/src/generators/generate_models.dart';
import 'package:firestore_builder/src/generators/generate_reference_service.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:yaml/yaml.dart';

Future<void> generate({
  required String? configFilePath,
}) async {
  configFilePath ??= defaultConfigPath;
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

  final config = await _parseYamlFile(
    file: file,
  );

  await Future.wait([
    generateModels(config: config),
    generateReferenceService(config: config),
  ]);
}

Future<YamlConfig> _parseYamlFile({
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

  return YamlConfig.fromYaml(
    yamlMap,
  );
}
