import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

part 'collection.freezed.dart';

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String name,
    required String modelName,
    required List<CollectionField> fields,
    required List<Collection> subCollections,
    required List<Collection> collectionPath,
    required YamlConfig configLight,
  }) = _Collection;

  const Collection._();
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
              (yamlMap) => CollectionField.fromYaml(
                yamlMap: yamlMap,
                configLight: configLight,
              ),
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

    return collection.copyWith(
      subCollections: subCollections,
    );
  }

  List<Collection> get allCollection {
    return [
      this,
      ...subCollections.expand((c) => c.allCollection),
    ].toList();
  }

  Parameter get documentFamilyParameter {
    final Reference type;
    if (collectionPath.isEmpty) {
      type = modelIdReference;
    } else {
      type = modelPathReference;
    }

    return Parameter(
      (p) => p
        ..name = type.symbol!.camelCase
        ..type = type,
    );
  }

  Parameter? get collectionFamilyParameter {
    if (collectionPath.isEmpty) {
      return null;
    }

    final Reference type;
    if (collectionPath.length == 1) {
      final collection = collectionPath.first;
      type = collection.modelIdReference;
    } else {
      final last = collectionPath.last;
      type = last.modelPathReference;
    }

    return Parameter(
      (p) => p
        ..name = type.symbol!.camelCase
        ..type = type,
    );
  }

  String get _camelName => name.camelCase;
  String get _pascalName => name.pascalCase;

  String get _modelCamelName => modelName.camelCase;
  String get _modelPascalName => modelName.pascalCase;
  String get _modelSnakeName => modelName.snakeCase;

  String get modelClassName => modelName.pascalCase;
  String get modelIdClassName => '${modelClassName}Id';
  String get modelPathClassName => '${modelClassName}Path';
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

  Reference get modelPathReference => Reference(
        modelPathClassName.pascalCase,
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
}
