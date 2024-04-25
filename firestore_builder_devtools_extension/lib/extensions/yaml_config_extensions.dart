import 'package:collection/collection.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/extensions/list_extensions.dart';
import 'package:yaml_edit/yaml_edit.dart';

extension YamlConfigExtensions on YamlConfig {
  String toCode() {
    final yamlEditor = YamlEditor('')..update([], toYaml());
    return yamlEditor.toString();
  }

  YamlConfig replaceCollection(
    Collection collection,
  ) {
    return updateCollection(
      replace: (_) => collection,
      collectionPath: [
        ...collection.collectionPathNames,
        collection.name,
      ],
    );
  }

  YamlConfig removeCollection(
    Collection collection,
  ) {
    return updateCollection(
      replace: (_) => null,
      collectionPath: [
        ...collection.collectionPathNames,
        collection.name,
      ],
    );
  }

  YamlConfig updateCollection({
    required Collection? Function(Collection? collection) replace,
    required List<String> collectionPath,
  }) {
    if (collectionPath.isEmpty) {
      final newCollection = replace(null);
      return copyWith(
        collections: [
          ...collections,
          if (newCollection != null) newCollection,
        ],
      );
    }

    final firstPathName = collectionPath.first;
    final nextCollectionPath = collectionPath.sublist(1);

    if (nextCollectionPath.isEmpty) {
      return copyWith(
        collections: collections.addOrReplaceWhere(
          where: (c) => c.name == firstPathName,
          replace: replace,
        ),
      );
    }

    return copyWith(
      collections: collections.map(
        (c) {
          if (c.name == firstPathName) {
            return c.updateCollection(
              replace: replace,
              collectionPath: nextCollectionPath,
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
    return collectionPath.collectionNames;
  }

  Collection updateCollection({
    required Collection? Function(Collection?) replace,
    required List<String> collectionPath,
  }) {
    if (collectionPath.isEmpty) {
      final newCollection = replace(null);
      return copyWith(
        subCollections: [
          ...subCollections,
          if (newCollection != null) newCollection,
        ],
      );
    }

    final firstPathName = collectionPath.first;
    final nextCollectionPath = collectionPath.sublist(1);

    if (nextCollectionPath.isEmpty) {
      return copyWith(
        subCollections: subCollections.addOrReplaceWhere(
          where: (c) => c.name == firstPathName,
          replace: replace,
        ),
      );
    }

    return copyWith(
      subCollections: subCollections.map(
        (c) {
          if (c.name == firstPathName) {
            return c.updateCollection(
              replace: replace,
              collectionPath: nextCollectionPath,
            );
          }
          return c;
        },
      ).toList(),
    );
  }

  Collection updatePathAtIndex({
    required int index,
    required Collection collection,
  }) {
    return copyWith(
      collectionPath: [
        ...collectionPath.sublist(0, index),
        collection,
        if (collectionPath.length > index + 1) ...collectionPath.sublist(index + 1),
      ],
      subCollections: subCollections
          .map(
            (e) => e.updatePathAtIndex(index: index, collection: collection),
          )
          .toList(),
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
      return this;
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

extension CollectionListExtensions on List<Collection> {
  List<String> get collectionNames {
    return map((c) => c.name).toList();
  }
}
