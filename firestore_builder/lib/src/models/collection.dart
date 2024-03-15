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
    required this.configLight,
  });

  factory Collection.fromYaml({
    required YamlMap yamlMap,
    required YamlConfig configLight,
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
      configLight: configLight,
    );
  }

  final String name;
  final String modelName;
  final List<CollectionField> fields;
  final List<Collection> subCollections;
  final YamlConfig configLight;

  String get _camelName => name.camelCase;
  String get _pascalName => name.pascalCase;

  String get _modelCamelName => modelName.camelCase;
  String get _modelPascalName => modelName.pascalCase;
  String get _modelSnakeName => modelName.snakeCase;

  String get modelClassName => modelName.pascalCase;
  String get modelIdClassName => '${modelClassName}Id';
  String get modelIdFieldName => modelIdClassName.camelCase;
  String get modelIdValueFieldName => 'value';
  String get modelProviderName => '${modelClassName}Provider'.camelCase;
  String get modelStreamProviderName => '${modelClassName}StreamProvider'.camelCase;
  String get collectionProviderName => '${modelClassName}CollectionProvider'.camelCase;
  String get collectionStreamProviderName => '${modelClassName}CollectionStreamProvider'.camelCase;

  String get modelFileName => _modelSnakeName;
  String get stateFileName => '${_modelSnakeName}_states';

  String get modelFilePath => '${configLight.modelsPath}/$modelFileName.dart';
  String get stateFilePath => '${configLight.statesPath}/$stateFileName.dart';

  String get _modelFileUrl {
    return modelFilePath.toPackageUrl(projectName: configLight.projectName);
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

  String get getCollectionMethodName => 'get${_pascalName}Collection';
  String get getCollectionWhereMethodName => 'get${_pascalName}CollectionWhere';
  String get getDocumentMethodName => 'get$_modelPascalName';
  String get addDocumentMethodName => 'add$_modelPascalName';
  String get setDocumentMethodName => 'set$_modelPascalName';
  String get deleteDocumentMethodName => 'delete$_modelPascalName';
  String get updateDocumentMethodName => 'update$_modelPascalName';

  @override
  List<Object> get props => [
        name,
        modelName,
        fields,
        subCollections,
        configLight,
      ];
}
