import 'package:collection/collection.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:yaml_edit/yaml_edit.dart';

extension YamlConfigExtensions on YamlConfig {
  String toCode() {
    final yamlEditor = YamlEditor('')..update([], toYaml());
    return yamlEditor.toString();
  }

  YamlConfig replaceCollection(
    Collection collection,
  ) {
    final collectionPath = collection.collectionPathNames;

    if (collectionPath.isEmpty) {
      final newSubCollections = collections.toList()
        ..removeWhere((element) => element.name == collection.name)
        ..add(collection);
      return copyWith(collections: newSubCollections);
    }

    final firstPathName = collectionPath.first;

    return copyWith(
      collections: collections.map(
        (c) {
          if (c.name == firstPathName) {
            return c.replaceCollection(
              collection: collection,
              collectionPath: collectionPath.sublist(1),
            );
          }
          return c;
        },
      ).toList(),
    );
  }

  Collection? collectionFromPath(List<String> collectionPath) {
    if (collectionPath.isEmpty) {
      return null;
    }

    final collection = collections.firstWhereOrNull(
      (collection) => collection.name == collectionPath.first,
    );

    if (collection == null) {
      return null;
    }

    final nextCollectionPath = collectionPath.sublist(1);
    return collection.collectionFromPath(nextCollectionPath);
  }

  List<Collection> collectionPathFromNames(List<String> collectionPath) {
    if (collectionPath.isEmpty) {
      return [];
    }

    final subCollection = collections.firstWhereOrNull(
      (subCollection) => subCollection.name == collectionPath.first,
    );

    if (subCollection == null) {
      return [];
    }

    final nextCollectionPath = collectionPath.sublist(1);
    return [
      subCollection,
      ...subCollection.collectionPathFromNames(nextCollectionPath),
    ];
  }
}

extension CollectionExtensions on Collection {
  bool isEqual(Collection collection) {
    return name == collection.name && collectionPath == collection.collectionPath;
  }

  List<String> get collectionPathNames {
    return collectionPath.map((c) => c.name).toList();
  }

  Collection replaceCollection({
    required Collection collection,
    required List<String> collectionPath,
  }) {
    if (collectionPath.isEmpty) {
      final newSubCollections = subCollections.toList()
        ..removeWhere((element) => element.name == collection.name)
        ..add(collection);
      return copyWith(subCollections: newSubCollections);
    }

    final firstPathName = collectionPath.first;
    return copyWith(
      subCollections: subCollections.map(
        (c) {
          if (c.name == firstPathName) {
            return c.replaceCollection(
              collection: collection,
              collectionPath: collectionPath.sublist(1),
            );
          }
          return c;
        },
      ).toList(),
    );
  }

  Collection? collectionFromPath(List<String> collectionPath) {
    if (collectionPath.isEmpty) {
      return this;
    }

    final collection = subCollections.firstWhereOrNull(
      (collection) => collection.name == collectionPath.first,
    );

    if (collection == null) {
      return null;
    }

    final nextCollectionPath = collectionPath.sublist(1);
    return collection.collectionFromPath(nextCollectionPath);
  }

  List<Collection> collectionPathFromNames(List<String> collectionPath) {
    if (collectionPath.isEmpty) {
      return [];
    }

    final subCollection = subCollections.firstWhereOrNull(
      (subCollection) => subCollection.name == collectionPath.first,
    );

    if (subCollection == null) {
      return [];
    }

    final nextCollectionPath = collectionPath.sublist(1);
    return [
      subCollection,
      ...subCollection.collectionPathFromNames(nextCollectionPath),
    ];
  }
}
