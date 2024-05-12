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
    final configFileUri = await _getConfigFileUri();

    if (dtcConnection == null || configFileUri == null) {
      return;
    }

    await dtcConnection.writeFileAsString(configFileUri, yamlConfig.toCode());
  }

  Future<YamlConfig?> getCurrentYamlConfig() async {
    final configFileUri = await _getConfigFileUri();
    if (configFileUri == null) {
      return null;
    }

    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null) {
      return null;
    }

    try {
      final fileContent = await dtcConnection.readFileAsString(configFileUri);
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

  Future<String?> getProjectName() async {
    final pubspecFileUri = await _getRootFileUri(fileName: pubspecFileName);
    if (pubspecFileUri == null) {
      return null;
    }

    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null) {
      return null;
    }

    try {
      final fileContent = await dtcConnection.readFileAsString(pubspecFileUri);
      final content = fileContent.content;
      if (content == null) {
        return null;
      }

      final yamlMap = loadYaml(content);
      if (yamlMap is! YamlMap) {
        return null;
      }

      final projectName = yamlMap['name'];
      if (projectName is! String) {
        return null;
      }
      return projectName;
    } catch (e) {
      return null;
    }
  }

  Future<Uri?> _getConfigFileUri() async {
    return _getRootFileUri(fileName: defaultConfigFileName);
  }

  Future<Uri?> _getRootFileUri({required String fileName}) async {
    final rootFolder = await _getRootFolder();
    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null || rootFolder == null) {
      return null;
    }

    final fileUri = Uri.file(join(rootFolder.path, fileName));
    return fileUri;
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
