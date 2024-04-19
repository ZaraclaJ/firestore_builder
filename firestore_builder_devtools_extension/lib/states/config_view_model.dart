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

  void selectCollection(Collection? collection) {
    if (collection == null) {
      ref.read(selectedCollectionPathNamesProvider.notifier).state = [];
      return;
    }
    final path = [
      ...collection.collectionPath.map((e) => e.name),
      collection.name,
    ];
    ref.read(selectedCollectionPathNamesProvider.notifier).state = path;
  }

  Collection startCollection({
    required Collection? inCollection,
    required String collectionName,
    required String modelName,
  }) {
    final newCollection = Collection(
      name: collectionName,
      modelName: modelName,
      fields: [],
      subCollections: [],
      collectionPath: [
        if (inCollection != null) ...[
          ...inCollection.collectionPath,
          inCollection,
        ],
      ],
      configLight: ref.read(configLightProvider),
    );

    final lastPathCollection = newCollection.collectionPath.lastOrNull;
    if (lastPathCollection != null) {
      _replaceCollection(
        lastPathCollection.copyWith(
          subCollections: [
            ...lastPathCollection.subCollections,
            newCollection,
          ],
        ),
      );
    }

    _replaceCollection(newCollection);

    return newCollection;
  }

  CollectionField addField({
    required Collection inCollection,
    required String fieldName,
    required FieldType type,
    required bool acceptFieldValue,
  }) {
    final newField = CollectionField(
      name: fieldName,
      type: type,
      acceptFieldValue: acceptFieldValue,
      configLight: ref.read(configLightProvider),
    );

    _replaceCollection(
      inCollection.copyWith(
        fields: [
          ...inCollection.fields,
          newField,
        ],
      ),
    );

    return newField;
  }

  void _replaceCollection(Collection newCollection) {
    ref.read(configProvider.notifier).update(
      (config) {
        final subCollections = config.collections;

        final index = subCollections.indexWhere((element) {
          return newCollection.isEqual(element);
        });

        if (index != -1) {
          final newSubCollections = subCollections.toList();
          newSubCollections[index] = newCollection;
          return config.copyWith(
            collections: newSubCollections,
          );
        }

        return config.copyWith(
          collections: subCollections.map((e) => e.replaceCollection(newCollection)).toList(),
        );
      },
    );
  }
}

extension on Collection {
  bool isEqual(Collection collection) {
    return name == collection.name && collectionPath == collection.collectionPath;
  }

  Collection replaceCollection(Collection newCollection) {
    final index = subCollections.indexWhere((element) {
      return newCollection.isEqual(element);
    });

    if (index != -1) {
      final newSubCollections = subCollections.toList();
      newSubCollections[index] = newCollection;
      return copyWith(
        subCollections: newSubCollections,
      );
    }

    return copyWith(
      subCollections: subCollections.map((e) => e.replaceCollection(newCollection)).toList(),
    );
  }
}
