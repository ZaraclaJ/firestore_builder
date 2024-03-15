import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
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
    required this.collectionPath,
    required this.configLight,
  });

  factory Collection.fromYaml({
    required YamlMap yamlMap,
    required YamlConfig configLight,
    required List<Collection> currentPath,
  }) {
    final collectionMap = yamlMap[collectionKey];
    if (collectionMap is! YamlMap) {
      throw Exception(
        '''
Invalid collection definition, missing or invalid collection map: $yamlMap
''',
      );
    }

    final name = collectionMap[collectionNameKey];
    if (name is! String) {
      throw Exception(
        '''
Invalid collection definition, missing or invalid collection_name key: $collectionMap

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

    final collection = Collection(
      name: name,
      modelName: modelName,
      fields: fields,
      subCollections: const [],
      collectionPath: currentPath,
      configLight: configLight,
    );

    final subCollections = yamlMap.collections(
      configLight: configLight,
      currentPath: [
        ...currentPath,
        collection,
      ],
    );

    return collection._copyWithSubCollections(subCollections);
  }

  final String name;
  final String modelName;
  final List<CollectionField> fields;
  final List<Collection> subCollections;
  final List<Collection> collectionPath;
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
  String get collectionWhereStreamMethodName => '${_camelName}CollectionWhereStream';
  String get documentStreamMethodName => '${_modelCamelName}Stream';

  String get getCollectionMethodName => 'get${_pascalName}Collection';
  String get getCollectionWhereMethodName => 'get${_pascalName}CollectionWhere';
  String get getDocumentMethodName => 'get$_modelPascalName';
  String get addDocumentMethodName => 'add$_modelPascalName';
  String get setDocumentMethodName => 'set$_modelPascalName';
  String get deleteDocumentMethodName => 'delete$_modelPascalName';
  String get updateDocumentMethodName => 'update$_modelPascalName';

  Parameter get whereFunctionParameter => Parameter(
        (p) => p
          ..named = true
          ..required = true
          ..name = FirestoreSymbols.whereMethod
          ..type = FirestoreTypes.whereFunctionOf(modelReference),
      );

  Collection _copyWithSubCollections(List<Collection> subCollections) {
    final collection = this;
    return Collection(
      name: collection.name,
      modelName: collection.modelName,
      fields: collection.fields,
      configLight: collection.configLight,
      collectionPath: collection.collectionPath,
      subCollections: subCollections,
    );
  }

  @override
  List<Object> get props => [
        name,
        modelName,
        fields,
        subCollections,
        configLight,
      ];
}
