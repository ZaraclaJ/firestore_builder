import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
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
        '''
Invalid collection definition, there should be only one key: $yamlMap''',
      );
    }

    final name = keys.first;

    final collectionMap = yamlMap[name];
    if (collectionMap is! YamlMap) {
      throw Exception(
        '''
Invalid collection definition, the value should be a map: $collectionMap''',
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
