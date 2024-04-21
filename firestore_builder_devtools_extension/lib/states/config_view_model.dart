import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/extensions/string_extensions.dart';
import 'package:firestore_builder_devtools_extension/extensions/yaml_config_extensions.dart';
import 'package:firestore_builder_devtools_extension/layouts/code_layout/code_layout.dart';
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

  void updateYamlCode(String code) {
    try {
      ref.read(codeErrorProvider.notifier).state = null;
      final newConfig = code.parseCodeIntoYamlConfig();
      ref.read(configProvider.notifier).state = newConfig;
    } catch (e) {
      ref.read(codeErrorProvider.notifier).state = e.toString();
    }
  }

  void updateProjectName(String projectName) {
    ref.read(configProvider.notifier).update(
      (config) {
        return config.copyWith(projectName: projectName);
      },
    );
  }

  void updateOutputPath(String outputPath) {
    ref.read(configProvider.notifier).update(
      (config) {
        return config.copyWith(outputPath: outputPath);
      },
    );
  }

  void updateClear(bool clear) {
    ref.read(configProvider.notifier).update(
      (config) {
        return config.copyWith(clear: clear);
      },
    );
  }

  void selectCollection(Collection? collection) {
    if (collection == null) {
      ref.read(selectedCollectionPathNamesProvider.notifier).state = [];
      return;
    }
    final path = [
      ...collection.collectionPathNames,
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

    _replaceCollection(newCollection);

    return newCollection;
  }

  void removeCollection(Collection collection) {
    ref.read(configProvider.notifier).update(
      (config) {
        return config.removeCollection(collection);
      },
    );
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
        return config.replaceCollection(newCollection);
      },
    );
  }
}
