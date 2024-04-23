import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/extensions/string_extensions.dart';
import 'package:firestore_builder_devtools_extension/models/collection_name_error.dart';
import 'package:firestore_builder_devtools_extension/models/model_name_error.dart';
import 'package:firestore_builder_devtools_extension/path/path_value.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:firestore_builder_devtools_extension/widgets/label_value_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

final _inCollectionGetter = Provider<Collection?>(
  (ref) => throw Exception('_inCollectionGetter not found'),
);

final _collectionGetter = Provider<Collection?>(
  (ref) => throw Exception('_collectionGetter not found'),
);

final _collectionNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _modelNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _collectionNameErrorProvider = Provider.autoDispose<CollectionNameError?>(
  (ref) {
    final collectionName = ref.watch(_collectionNameProvider);
    final isEmpty = collectionName.isTrimmedEmpty;
    if (isEmpty) {
      return CollectionNameErrorEmpty(collectionName);
    }

    final onlyLetters = collectionName.isOnlyLetters;
    if (!onlyLetters) {
      return CollectionNameErrorInvalid(collectionName);
    }

    final inCollection = ref.watch(_inCollectionGetter);
    final collection = ref.watch(_collectionGetter);
    final config = ref.watch(configProvider);
    final subCollections = inCollection == null ? config.collections : inCollection.subCollections;
    final otherCollections = subCollections.where((c) => c != collection).toList();
    final alreadyExist = otherCollections.any((c) => c.name.toLowerCase() == collectionName.toLowerCase());
    if (alreadyExist) {
      return CollectionNameErrorAlreadyExists(collectionName);
    }
    return null;
  },
  dependencies: [
    _collectionNameProvider,
    _inCollectionGetter,
    _collectionGetter,
    configProvider,
  ],
);

final _modelClassErrorProvider = Provider.autoDispose<ModelNameError?>(
  (ref) {
    final modelName = ref.watch(_modelNameProvider);
    final isEmpty = modelName.isTrimmedEmpty;
    if (isEmpty) {
      return ModelNameErrorEmpty(modelName);
    }

    final onlyLetters = modelName.isOnlyLetters;
    if (!onlyLetters) {
      return ModelNameErrorInvalid(modelName);
    }
    final collection = ref.watch(_collectionGetter);
    final otherCollections = ref.watch(configProvider).allCollections.where((c) => c != collection).toList();
    final alreadyExist = otherCollections.any((c) => c.modelName.toLowerCase() == modelName.toLowerCase());
    if (alreadyExist) {
      return ModelNameErrorAlreadyExists(modelName);
    }

    return null;
  },
  dependencies: [
    _modelNameProvider,
    _collectionGetter,
    configProvider,
  ],
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    final modelClassError = ref.watch(_modelClassErrorProvider);
    final collectionNameError = ref.watch(_collectionNameErrorProvider);
    return collectionNameError == null && modelClassError == null;
  },
  dependencies: [
    _modelClassErrorProvider,
    _collectionNameErrorProvider,
  ],
);

class CollectionDialog extends StatelessWidget {
  const CollectionDialog({
    required this.inCollection,
    required this.collection,
    super.key,
  });

  final Collection? inCollection;
  final Collection? collection;

  static Future<void> showStart({
    required BuildContext context,
    required Collection? inCollection,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CollectionDialog(
          inCollection: inCollection,
          collection: null,
        );
      },
    );
  }

  static Future<void> showEdit({
    required BuildContext context,
    required Collection collection,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CollectionDialog(
          inCollection: collection.collectionPath.lastOrNull,
          collection: collection,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final collection = this.collection;
    return ProviderScope(
      overrides: [
        _inCollectionGetter.overrideWithValue(inCollection),
        _collectionGetter.overrideWithValue(collection),
        _collectionNameProvider.overrideWith((ref) => collection?.name ?? ''),
        _modelNameProvider.overrideWith((ref) => collection?.modelName ?? ''),
      ],
      child: const _Layout(),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(_collectionGetter);
    return AppDialog(
      title: collection == null ? 'Start a collection' : 'Edit ${collection.name} collection',
      content: const _Content(),
      actions: const [
        CancelButton(),
        _SaveButton(),
      ],
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        LabelValueRow(
          label: 'Parent path:',
          value: _Path(),
        ),
        AppGap.semiBig(),
        _CollectionNameInput(),
        AppGap.semiBig(),
        _ModelNameInput(),
        AppGap.semiBig(),
        AppDivider.horizontal(),
      ],
    );
  }
}

class _Path extends ConsumerWidget {
  const _Path();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(_inCollectionGetter);
    return PathValue(
      collection: collection,
    );
  }
}

class _CollectionNameInput extends ConsumerWidget {
  const _CollectionNameInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppInput(
      initialText: ref.watch(_collectionNameProvider),
      label: 'Collection ID',
      hintText: 'Enter the collection ID',
      errorText: ref.watch(_collectionNameErrorProvider.select((value) => value?.error)),
      withError: true,
      onChanged: (value) {
        ref.read(_collectionNameProvider.notifier).state = value;
      },
    );
  }
}

class _ModelNameInput extends ConsumerWidget {
  const _ModelNameInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppInput(
      initialText: ref.watch(_modelNameProvider),
      label: 'Model class name',
      hintText: 'Enter the name of the model class',
      errorText: ref.watch(_modelClassErrorProvider.select((value) => value?.error)),
      withError: true,
      onChanged: (value) {
        ref.read(_modelNameProvider.notifier).state = value;
      },
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSave = ref.watch(_canSaveProvider);
    return SaveButton(
      onPressed: canSave
          ? () {
              final collection = ref.read(_collectionGetter);
              final viewModel = ref.read(configViewModelProvider);
              final collectionName = ref.read(_collectionNameProvider);
              final modelName = ref.read(_modelNameProvider).pascalCase;

              final Collection newCollection;

              if (collection != null) {
                // Edit collection
                newCollection = viewModel.editCollection(
                  collection: collection,
                  collectionName: collectionName,
                  modelName: modelName,
                );
              } else {
                // Start collection
                final inCollection = ref.read(_inCollectionGetter);
                newCollection = viewModel.startCollection(
                  inCollection: inCollection,
                  collectionName: collectionName,
                  modelName: modelName,
                );
              }

              viewModel.selectCollection(newCollection);
              Navigator.of(context).pop();
            }
          : null,
    );
  }
}
