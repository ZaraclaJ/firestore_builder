import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

part 'yaml_config.freezed.dart';

@freezed
class YamlConfig with _$YamlConfig {
  const factory YamlConfig({
    required String outputPath,
    required bool clear,
    required List<Collection> collections,
    required String projectName,
  }) = _YamlConfig;

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

    final configLight = YamlConfig(
      projectName: projectName,
      outputPath: outputPath,
      collections: const [],
      clear: clear ?? false,
    );

    final collections = firestoreBuilderConfig.collections(
      configLight: configLight,
      currentPath: [],
    );

    return configLight.copyWith(
      collections: collections,
    );
  }
}

extension YamlConfigExtensions on YamlConfig {
  Map<String, dynamic> toYaml() {
    return {
      firestoreBuilderKey: {
        outputKey: outputPath,
        clearKey: clear,
        collectionsKey: collections.map((e) => e.toYaml()).toList(),
      },
    };
  }

  List<Collection> get allCollections {
    return collections.expand((c) => c.allCollection).toList();
  }

  List<CollectionField> get allFields {
    return allCollections.expand((c) => c.fields).toList();
  }

  String get convertersPath => '$outputPath/converters/freezed_converters.dart';
  String get modelsPath => '$outputPath/models';
  String get servicesPath => '$outputPath/services';
  String get statesPath => '$outputPath/states';

  String get firestoreProviderName => 'firestoreProvider';
  Reference get firestoreProviderReference => Reference(
        firestoreProviderName,
        referenceServiceClass.url,
      );

  ServiceClass get referenceServiceClass => ServiceClass(
        className: 'FirestoreReferenceService',
        folderPath: servicesPath,
        projectName: projectName,
      );

  ServiceClass get streamServiceClass => ServiceClass(
        className: 'FirestoreStreamService',
        folderPath: servicesPath,
        projectName: projectName,
      );

  ServiceClass get queryServiceClass => ServiceClass(
        className: 'FirestoreQueryService',
        folderPath: servicesPath,
        projectName: projectName,
      );

  ServiceClass get updatedValueClass => ServiceClass(
        className: 'UpdatedValue',
        folderPath: modelsPath,
        projectName: projectName,
      );
}

extension YamlMapExtensions on YamlMap {
  List<Collection> collections({
    required YamlConfig configLight,
    required List<Collection> currentPath,
  }) {
    final yamlMap = this;
    final yamlCollections = yamlMap[collectionsKey] ?? yamlMap[subCollectionsKey];
    if (yamlCollections is! YamlList?) {
      throw Exception('''
The configuration file does not contain a correct collections section: $yamlMap
''');
    }

    final collections = yamlCollections?.nodes.whereType<YamlMap>().map(
          (y) {
            return Collection.fromYaml(
              yamlMap: y,
              configLight: configLight,
              currentPath: currentPath,
            );
          },
        ).toList() ??
        [];

    return collections;
  }
}

class ServiceClass {
  const ServiceClass({
    required String className,
    required String folderPath,
    required String projectName,
  })  : _projectName = projectName,
        _folderPath = folderPath,
        _className = className;

  final String _className;
  final String _folderPath;
  final String _projectName;

  String get className => _className;
  String get providerName => '${_className}Provider'.camelCase;
  String get path => '$_folderPath/$fileName.dart';
  String get fileName => className.snakeCase;
  String get url => path.toPackageUrl(projectName: _projectName);

  Reference get reference => Reference(
        className.pascalCase,
        url,
      );
  Reference get providerReference => Reference(
        providerName,
        url,
      );

  Field get field => Field(
        (f) => f
          ..name = className.privateName
          ..modifier = FieldModifier.final$
          ..type = reference,
      );

  Reference get fieldReference => Reference(
        field.name,
        url,
      );
}
