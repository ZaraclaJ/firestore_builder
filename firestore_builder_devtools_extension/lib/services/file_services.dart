import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/extensions/yaml_config_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

final fileServiceProvider = Provider<FileService>(
  (ref) => const FileService(),
);

class FileService {
  const FileService();

  Future<void> saveYamlConfig(YamlConfig yamlConfig) async {
    final dtcConnection = dtdManager.connection.value;
    final configFile = await _getConfigUri();

    if (dtcConnection == null || configFile == null) {
      return;
    }

    await dtcConnection.writeFileAsString(configFile, yamlConfig.toCode());
  }

  Future<YamlConfig?> getCurrentYamlConfig() async {
    final configFile = await _getConfigUri();
    if (configFile == null) {
      return null;
    }

    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null) {
      return null;
    }

    try {
      final fileContent = await dtcConnection.readFileAsString(configFile);
      final content = fileContent.content;
      if (content == null) {
        return null;
      }

      final yamlMap = loadYaml(content);
      if (yamlMap is! YamlMap) {
        return null;
      }

      return YamlConfig.fromYaml(yamlMap);
    } catch (e) {
      return null;
    }
  }

  Future<Uri?> _getConfigUri() async {
    final rootFolder = await _getRootFolder();
    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null || rootFolder == null) {
      return null;
    }

    final configUri = Uri.file(join(rootFolder.path, defaultConfigFilPath));
    return configUri;
  }

  Future<Uri?> _getRootFolder() async {
    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null) {
      return null;
    }

    final projectRoots = await dtcConnection.getProjectRoots();
    return projectRoots.uris?.firstOrNull;
  }
}
