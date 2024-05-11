import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

final fileServiceProvider = Provider<FileService>(
  (ref) => const FileService(),
);

class FileService {
  const FileService();

  Future<YamlConfig?> readFileAsString(String path) async {
    final rootFolder = await _getRootFolder();
    final dtcConnection = dtdManager.connection.value;
    if (dtcConnection == null || rootFolder == null) {
      return null;
    }

    final contents = await dtcConnection.listDirectoryContents(rootFolder);
    final configFile = contents.uris?.firstWhere(
      (element) => basename(element.path) == path,
    );
    if (configFile == null) {
      return null;
    }

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
