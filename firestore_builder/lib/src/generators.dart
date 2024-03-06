import 'dart:io';

const String _defaultConfigPath = 'firestore_builder_config.yaml';

/// Generate Firestore Builder
Future<void> generate({
  required String outputPath,
  required String? configPath,
}) async {
  configPath ??= _defaultConfigPath;
  final file = File(configPath);
  final exist = file.existsSync();
  if (!exist) {
    throw Exception('''
File not found: $configPath
You should create a firestore_builder_config.yaml file in the root of your project
You can also indicate the path of your configuration file:
  dart run firestore_builder path/to/your/config.yaml
''');
  }

  print('ok');
}
