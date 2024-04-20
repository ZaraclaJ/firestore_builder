import 'package:firestore_builder/firestore_builder.dart';
import 'package:yaml/yaml.dart';

extension StringExtensions on String {
  YamlConfig parseCodeIntoYamlConfig() {
    final yamlMap = loadYaml(this) as YamlMap;
    return YamlConfig.fromYaml(yamlMap);
  }
}
