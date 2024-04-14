import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configProvider = StateProvider<YamlConfig>(
  (ref) => const YamlConfig(
    projectName: '',
    outputPath: 'lib/firestore',
    clear: true,
    collections: [
      Collection(
        configLight: YamlConfig(
          projectName: '',
          outputPath: 'lib/firestore',
          clear: true,
          collections: [],
        ),
        modelName: 'User',
        name: 'users',
        subCollections: [],
        collectionPath: [],
        fields: [],
      ),
    ],
  ),
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

final selectedCollectionProvider = StateProvider<Collection?>(
  (ref) => null,
);

final isCollectionSelectedProvider = Provider.autoDispose.family<bool, Collection>(
  (ref, collection) {
    final selectedCollection = ref.watch(selectedCollectionProvider);
    return selectedCollection == collection;
  },
);
