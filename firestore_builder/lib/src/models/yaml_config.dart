import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class YamlConfig extends Equatable {
  const YamlConfig({
    required this.projectName,
    required this.outputPath,
    required this.collections,
    required this.clear,
  });

  factory YamlConfig.fromYaml(
    YamlMap yamlMap,
  ) {
    final projectName = yamlMap[projectNameKey];
    if (projectName is! String) {
      throw Exception('''
Invalid pubspec.yaml, missing or invalid name key
''');
    }

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

    final clear = firestoreBuilderConfig[clearKey];
    if (clear is! bool?) {
      throw Exception('''
The configuration file does not contain a correct clear section: $firestoreBuilderConfig
''');
    }

    final yamlCollections = firestoreBuilderConfig[collectionsKey];
    if (yamlCollections is! YamlList?) {
      throw Exception('''
The configuration file does not contain a correct collections section: $firestoreBuilderConfig
''');
    }

    final yamlConfigLight = YamlConfig(
      projectName: projectName,
      outputPath: outputPath,
      collections: const [],
      clear: clear ?? false,
    );

    final collections = yamlCollections?.nodes
            .whereType<YamlMap>()
            .map(
              (e) => Collection.fromYaml(
                yamlMap: e,
                yamlConfigLight: yamlConfigLight,
              ),
            )
            .toList() ??
        [];

    return yamlConfigLight.copyWithCollections(collections);
  }

  YamlConfig copyWithCollections(List<Collection> collections) {
    final config = this;
    return YamlConfig(
      projectName: config.projectName,
      outputPath: config.outputPath,
      clear: config.clear,
      collections: collections,
    );
  }

  final String outputPath;
  final List<Collection> collections;
  final String projectName;
  final bool clear;

  String get modelsPath => '$outputPath/models';
  String get servicesPath => '$outputPath/services';
  String get statesPath => '$outputPath/states';

  String get firestoreProviderName => 'firestoreProvider';
  Reference get firestoreProviderReference => Reference(
        firestoreProviderName,
        _referenceServiceUrl,
      );

  String get referenceServiceClassName => 'FirestoreReferenceService';
  String get referenceServiceProviderName => '${referenceServiceClassName}Provider'.camelCase;
  String get referenceServicePath => '$servicesPath/${referenceServiceClassName.snakeCase}.dart';
  String get _referenceServiceUrl => referenceServicePath.toPackageUrl(config: this);
  Reference get referenceServiceReference => Reference(
        referenceServiceClassName.pascalCase,
        _referenceServiceUrl,
      );
  Reference get referenceServiceProviderReference => Reference(
        referenceServiceProviderName,
        _referenceServiceUrl,
      );

  String get streamServiceClassName => 'FirestoreStreamService';
  String get streamServiceProviderName => '${streamServiceClassName}Provider'.camelCase;
  String get streamServicePath => '$servicesPath/${streamServiceClassName.snakeCase}.dart';
  String get _streamServiceUrl => streamServicePath.toPackageUrl(config: this);
  Reference get streamServiceReference => Reference(
        streamServiceClassName.pascalCase,
        _streamServiceUrl,
      );
  Reference get streamServiceProviderReference => Reference(
        streamServiceProviderName,
        _streamServiceUrl,
      );

  @override
  List<Object> get props => [
        outputPath,
        collections,
        projectName,
        clear,
      ];
}
