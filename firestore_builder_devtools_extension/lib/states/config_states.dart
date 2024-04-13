import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configProvider = Provider<YamlConfig>(
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

final collectionsProvider = Provider<List<Collection>>(
  (ref) {
    return ref.watch(configProvider).collections;
  },
);
