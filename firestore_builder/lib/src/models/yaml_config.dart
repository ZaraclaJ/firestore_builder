import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:yaml/yaml.dart';

class YamlConfig extends Equatable {
  const YamlConfig({
    required this.outputPath,
    required this.collections,
  });

  factory YamlConfig.fromYaml(
    YamlMap yamlMap,
  ) {
    final firestoreBuilderConfig = yamlMap['firestore_builder'];
    if (firestoreBuilderConfig is! YamlMap) {
      throw Exception('''
The configuration file does not contain a firestore_builder section: $yamlMap
''');
    }

    final outputPath = firestoreBuilderConfig['output'];
    if (outputPath is! String) {
      throw Exception('''
The configuration file does not contain an output section: $firestoreBuilderConfig
''');
    }

    final yamlCollections = firestoreBuilderConfig['collections'];
    if (yamlCollections is! YamlList?) {
      throw Exception('''
The configuration file does not contain a correct collections section: $firestoreBuilderConfig
''');
    }

    final collections = yamlCollections?.nodes
            .whereType<YamlMap>()
            .map(
              Collection.fromYaml,
            )
            .toList() ??
        [];

    return YamlConfig(
      outputPath: outputPath,
      collections: collections,
    );
  }

  final String outputPath;
  final List<Collection> collections;

  @override
  List<Object> get props => [
        outputPath,
        collections,
      ];
}
