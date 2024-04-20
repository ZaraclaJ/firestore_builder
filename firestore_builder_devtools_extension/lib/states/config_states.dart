import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/assets/pubspec_example.dart';
import 'package:firestore_builder_devtools_extension/extensions/yaml_config_extensions.dart';
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

final codeProvider = Provider<String>((ref) {
  final config = ref.watch(configProvider);
  return config.toCode();
});

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
