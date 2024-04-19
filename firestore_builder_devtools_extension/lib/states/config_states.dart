import 'package:collection/collection.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/assets/pubspec_example.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaml/yaml.dart';

const _defaultConfig = YamlConfig(
  projectName: '',
  outputPath: 'lib/firestore',
  clear: true,
  collections: [],
);

final initialConfigProvider = FutureProvider<YamlConfig>(
  (ref) async {
    try {
      final yamlMap = loadYaml(pubspecExample) as YamlMap;
      return YamlConfig.fromYaml(yamlMap);
    } catch (e) {
      throw Exception('''
Error parsing the pubspecExample file, $e
''');
    }
  },
);

final configProvider = StateProvider<YamlConfig>(
  (ref) {
    final initialConfig = ref.watch(initialConfigProvider).value;
    return initialConfig ?? _defaultConfig;
  },
);

final configLightProvider = Provider<YamlConfig>(
  (ref) {
    return ref.watch(configProvider).copyWith(
      collections: [],
    );
  },
);

final subCollectionsProvider = Provider.autoDispose.family<List<Collection>, Collection?>(
  (ref, collection) {
    if (collection == null) {
      return ref.watch(configProvider).collections;
    }

    return collection.subCollections;
  },
);

final selectedCollectionPathNamesProvider = StateProvider<List<String>>(
  (ref) => [],
);

final selectedCollectionProvider = Provider<Collection?>(
  (ref) {
    final path = ref.watch(selectedCollectionPathNamesProvider);
    if (path.isEmpty) {
      return null;
    }

    final config = ref.watch(configProvider);
    return config.collectionFromPath(path);
  },
);

final isCollectionSelectedProvider = Provider.autoDispose.family<bool, Collection>(
  (ref, collection) {
    final selectedCollection = ref.watch(selectedCollectionProvider);
    return selectedCollection == collection;
  },
);

final _collectionPathFromConfigProvider = Provider.autoDispose.family<List<Collection>, Collection?>(
  (ref, collection) {
    if (collection == null) {
      return [];
    }

    final config = ref.watch(configProvider);

    return config.collectionPathFromNames(
      collection.collectionPath
          .map(
            (collection) => collection.name,
          )
          .toList(),
    );
  },
);

final selectedCollectionPathProvider = Provider.autoDispose(
  (ref) {
    final selectedCollection = ref.watch(selectedCollectionProvider);
    return ref.watch(_collectionPathFromConfigProvider(selectedCollection));
  },
);

extension YamlConfigExtensions on YamlConfig {
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

extension on Collection {
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
}
