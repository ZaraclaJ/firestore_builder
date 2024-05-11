import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/extensions/yaml_config_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configProvider = StateProvider<YamlConfig>(
  (ref) => throw UnimplementedError(),
);

final codeProvider = Provider<String>(
  (ref) {
    final config = ref.watch(configProvider);
    return config.toCode();
  },
  dependencies: [
    configProvider,
  ],
);

final configLightProvider = Provider<YamlConfig>(
  (ref) {
    return ref.watch(configProvider).copyWith(
      collections: [],
    );
  },
  dependencies: [
    configProvider,
  ],
);

final subCollectionsProvider = Provider.autoDispose.family<List<Collection>, Collection?>(
  (ref, collection) {
    if (collection == null) {
      return ref.watch(configProvider).collections;
    }

    return collection.subCollections;
  },
  dependencies: [
    configProvider,
  ],
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
  dependencies: [
    configProvider,
  ],
);

final isCollectionSelectedProvider = Provider.autoDispose.family<bool, Collection>(
  (ref, collection) {
    final selectedCollection = ref.watch(selectedCollectionProvider);
    return selectedCollection == collection;
  },
  dependencies: [
    selectedCollectionProvider,
  ],
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
  dependencies: [
    configProvider,
  ],
);

final selectedCollectionPathProvider = Provider.autoDispose(
  (ref) {
    final selectedCollection = ref.watch(selectedCollectionProvider);
    return ref.watch(_collectionPathFromConfigProvider(selectedCollection));
  },
  dependencies: [
    selectedCollectionProvider,
    _collectionPathFromConfigProvider,
  ],
);
