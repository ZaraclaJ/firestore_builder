import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configViewModelProvider = Provider<ConfigViewModel>(
  (ref) => ConfigViewModel(
    ref: ref,
  ),
);

class ConfigViewModel {
  const ConfigViewModel({required this.ref});

  final Ref ref;

  Collection startCollection({
    required String collectionName,
    required String modelName,
  }) {
    final collection = Collection(
      name: collectionName,
      modelName: modelName,
      fields: [],
      subCollections: [],
      collectionPath: [],
      configLight: ref.read(configLightProvider),
    );
    ref.read(configProvider.notifier).update(
          (config) => config.copyWith(
            collections: [...config.collections, collection],
          ),
        );

    return collection;
  }
}
