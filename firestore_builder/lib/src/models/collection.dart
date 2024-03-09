import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
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

  String get _camelName => name.camelCase;

  String get _modelCamelName => modelName.camelCase;
  String get _modelSnakeName => modelName.snakeCase;

  String get modelClassName => modelName.pascalCase;
  String get modelIdClassName => '${modelClassName}Id';
  String get streamProviderName => '${modelClassName}StreamProvider'.camelCase;

  String get modelFileName => _modelSnakeName;
  String get stateFileName => '${_modelSnakeName}_states';

  String get modelFilePath => '${yamlConfigLight.modelsPath}/$modelFileName.dart';
  String get stateFilePath => '${yamlConfigLight.statesPath}/$stateFileName.dart';

  String get _modelFileUrl {
    return modelFilePath.toPackageUrl(config: yamlConfigLight);
  }

  Reference get modelReference => Reference(
        modelName.pascalCase,
        _modelFileUrl,
      );

  Reference get modelIdReference => Reference(
        modelIdClassName.pascalCase,
        _modelFileUrl,
      );

  String get collectionReferenceMethodName => '${_camelName}Collection';
  String get documentReferenceMethodName => '${_modelCamelName}Reference';

  String get collectionStreamMethodName => '${_camelName}CollectionStream';
  String get documentStreamMethodName => '${_modelCamelName}Stream';

  @override
  List<Object> get props => [
        name,
        modelName,
        fields,
        subCollections,
        yamlConfigLight,
      ];
}
