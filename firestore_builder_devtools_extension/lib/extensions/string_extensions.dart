import 'package:firestore_builder/firestore_builder.dart';
import 'package:yaml/yaml.dart';

extension StringExtensions on String {
  YamlConfig parseCodeIntoYamlConfig() {
    final yamlMap = loadYaml(this) as YamlMap;
    return YamlConfig.fromYaml(yamlMap);
  }

  bool get isTrimmedEmpty => trim().isEmpty;

  bool get isOnlyLetters {
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(trim());
  }
}
