import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class YamlConfig {
  const YamlConfig({
    required this.outputPath,
    required this.clearOutputFolder,
    required this.useRiverpod,
    required this.collections,
    required this.projectName,
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

    final projectName = firestoreBuilderConfig[projectNameKey];
    if (projectName is! String || projectName.trim().isEmpty) {
      throw Exception('''
The configuration file does not contain an $projectNameKey section: $firestoreBuilderConfig
''');
    }

    final outputPath = firestoreBuilderConfig[outputKey];
    if (outputPath is! String || outputPath.trim().isEmpty) {
      throw Exception('''
The configuration file does not contain an $outputKey section: $firestoreBuilderConfig
''');
    }

    final clear = firestoreBuilderConfig[clearOutputFolderKey];
    if (clear is! bool?) {
      throw Exception('''
The configuration file does not contain a correct $clearOutputFolderKey section: $firestoreBuilderConfig
''');
    }

    final useRiverpod = firestoreBuilderConfig[useRiverpodKey];
    if (useRiverpod is! bool?) {
      throw Exception('''
The configuration file does not contain a correct $useRiverpodKey section: $firestoreBuilderConfig
''');
    }

    final configLight = YamlConfig(
      projectName: projectName,
      outputPath: outputPath,
      collections: const [],
      clearOutputFolder: clear ?? true,
      useRiverpod: useRiverpod ?? false,
    );

    final collections = firestoreBuilderConfig.collections(
      configLight: configLight,
      currentPath: [],
    );

    return configLight.copyWith(
      collections: collections,
    );
  }

  /// The name of the project
  ///
  /// It is the name indicates in the pubspec.yaml file
  final String projectName;

  /// The path where the files will be generated
  ///
  /// ex: lib/firestore
  final String outputPath;

  /// If true, the output folder will be cleared before generating the files
  ///
  /// Default is true
  final bool clearOutputFolder;

  /// If true, riverpod singleton providers and states providers
  /// will be generated for services
  ///
  /// Default is false
  final bool useRiverpod;

  /// The firebase collections and subCollections to generate
  final List<Collection> collections;
}

extension YamlConfigExtensions on YamlConfig {
  YamlConfig copyWith({
    String? outputPath,
    bool? clearOutputFolder,
    bool? useRiverpod,
    List<Collection>? collections,
    String? projectName,
  }) {
    return YamlConfig(
      outputPath: outputPath ?? this.outputPath,
      clearOutputFolder: clearOutputFolder ?? this.clearOutputFolder,
      useRiverpod: useRiverpod ?? this.useRiverpod,
      collections: collections ?? this.collections,
      projectName: projectName ?? this.projectName,
    );
  }

  Map<String, dynamic> toYaml() {
    final collections = this.collections.map((e) => e.toYaml()).toList();

    return {
      firestoreBuilderKey: {
        projectNameKey: projectName,
        outputKey: outputPath,
        if (!clearOutputFolder) clearOutputFolderKey: clearOutputFolder,
        if (useRiverpod) useRiverpodKey: useRiverpod,
        if (collections.isNotEmpty) collectionsKey: collections,
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
