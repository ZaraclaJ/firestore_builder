import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:yaml/yaml.dart';

const String firestoreBuilderKey = 'firestore_builder';
const String outputKey = 'output';
const String collectionsKey = 'collections';

const String modelNameKey = 'model_name';
const String fieldsKey = 'fields';

class YamlConfig extends Equatable {
  const YamlConfig({
    required this.outputPath,
    required this.collections,
  });

  factory YamlConfig.fromYaml(
    YamlMap yamlMap,
  ) {
    final firestoreBuilderConfig = yamlMap[firestoreBuilderKey];
    if (firestoreBuilderConfig is! YamlMap) {
      throw Exception('''
The configuration file does not contain a firestore_builder section: $yamlMap
''');
    }

    final outputPath = firestoreBuilderConfig[outputKey];
    if (outputPath is! String) {
      throw Exception('''
The configuration file does not contain an output section: $firestoreBuilderConfig
''');
    }

    final yamlCollections = firestoreBuilderConfig[collectionsKey];
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

  String get modelsPath => '$outputPath/models';
  String get servicesPath => '$outputPath/services';
  String get referenceServicePath => '$servicesPath/firebase_reference_service.dart';

  @override
  List<Object> get props => [
        outputPath,
        collections,
      ];
}
