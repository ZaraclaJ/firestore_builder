import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class Collection extends Equatable {
  const Collection({
    required this.name,
    required this.modelName,
    required this.fields,
    required this.subCollections,
    required this.yamlConfigLight,
  });

  factory Collection.fromYaml({
    required YamlMap yamlMap,
    required YamlConfig yamlConfigLight,
  }) {
    final keys = yamlMap.keys.whereType<String>();
    if (keys.length != 1) {
      throw Exception(
        '''
Invalid collection definition, there should be only one key: $yamlMap
''',
      );
    }

    final name = keys.first;

    final collectionMap = yamlMap[name];
    if (collectionMap is! YamlMap) {
      throw Exception(
        '''
Invalid collection definition, missing or invalid collection map: $yamlMap
''',
      );
    }

    final modelName = collectionMap[modelNameKey];
    if (modelName is! String) {
      throw Exception(
        '''
Invalid collection definition, missing or invalid model_name key: $collectionMap
''',
      );
    }

    final yamlFields = collectionMap[fieldsKey];
    if (yamlFields is! YamlList?) {
      throw Exception(
        '''
Invalid collection definition, missing or invalid fields key: $collectionMap
''',
      );
    }

    final fields = yamlFields?.nodes
            .whereType<YamlMap>()
            .map(
              CollectionField.fromYaml,
            )
            .toList() ??
        const [];

    return Collection(
      name: name,
      modelName: modelName,
      fields: fields,
      subCollections: const [],
      yamlConfigLight: yamlConfigLight,
    );
  }

  final String name;
  final String modelName;
  final List<CollectionField> fields;
  final List<Collection> subCollections;
  final YamlConfig yamlConfigLight;

  String get snakeName => name.snakeCase;
  String get camelName => name.camelCase;

  String get modelClassName => modelName.pascalCase;
  String get modelIdClassName => '${modelClassName}Id';

  String get modelFilePath {
    return '${yamlConfigLight.modelsPath}/$snakeName.dart';
  }

  String get _modelFileUrl {
    final projectName = yamlConfigLight.projectName;
    final modelsPath = yamlConfigLight.modelsPath.withoutPrefix('lib/');
    return 'package:$projectName/$modelsPath/$snakeName.dart';
  }

  Reference get modelReference => Reference(
        modelName.pascalCase,
        _modelFileUrl,
      );

  Reference get modelIdReference => Reference(
        modelIdClassName.pascalCase,
        _modelFileUrl,
      );

  @override
  List<Object> get props => [
        name,
        modelName,
        fields,
        subCollections,
      ];
}
