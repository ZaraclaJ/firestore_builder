import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:yaml/yaml.dart';

class Collection extends Equatable {
  const Collection({
    required this.name,
    required this.fields,
    required this.subCollections,
  });

  factory Collection.fromYaml(
    YamlMap yamlMap,
  ) {
    final keys = yamlMap.keys.whereType<String>();
    if (keys.length != 1) {
      throw Exception(
        'Invalid collection definition, there should be only one key: $yamlMap',
      );
    }

    final name = keys.first;

    final collectionMap = yamlMap[name];
    if (collectionMap is! YamlMap) {
      throw Exception(
        'Invalid collection definition, the value should be a map: $collectionMap',
      );
    }

    final yamlFields = collectionMap['fields'] as YamlList?;
    final fields = yamlFields?.nodes
            .whereType<YamlMap>()
            .map(
              CollectionField.fromYaml,
            )
            .toList() ??
        const [];

    return Collection(
      name: name,
      fields: fields,
      subCollections: const [],
    );
  }

  final String name;
  final List<CollectionField> fields;
  final List<Collection> subCollections;

  @override
  List<Object> get props => [
        name,
        fields,
        subCollections,
      ];
}

class CollectionField extends Equatable {
  const CollectionField({
    required this.name,
    required this.type,
  });

  factory CollectionField.fromYaml(
    YamlMap yamlMap,
  ) {
    final keys = yamlMap.keys.whereType<String>();
    final values = yamlMap.values.whereType<String>();
    if (keys.length != 1 || values.length != 1) {
      throw Exception(
        'Invalid field definition, there should be only one key and one value: $yamlMap',
      );
    }

    final name = keys.first;
    final type = values.first;

    final fieldType = FieldType.fromTypeName(type);
    if (fieldType == null) {
      throw Exception('Unknown field type: $type');
    }

    return CollectionField(
      name: name,
      type: fieldType,
    );
  }

  final String name;
  final FieldType type;

  @override
  List<Object> get props => [
        name,
        type,
      ];
}

enum FieldType {
  string,
  number,
  boolean,
  map,
  array,
  timestamp,
  geopoint,
  reference;

  static FieldType? fromTypeName(String typeName) {
    return FieldType.values.firstWhereOrNull(
      (element) => element.typeName == typeName,
    );
  }

  String get typeName {
    return switch (this) {
      FieldType.string => 'string',
      FieldType.number => 'number',
      FieldType.boolean => 'boolean',
      FieldType.map => 'map',
      FieldType.array => 'array',
      FieldType.timestamp => 'timestamp',
      FieldType.geopoint => 'geopoint',
      FieldType.reference => 'reference',
    };
  }
}
