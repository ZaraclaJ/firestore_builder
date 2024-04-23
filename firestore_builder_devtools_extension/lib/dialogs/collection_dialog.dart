import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/path/path_value.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:firestore_builder_devtools_extension/widgets/label_value_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

final _collectionNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _modelNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _modelClassValidProvider = Provider.autoDispose<bool>(
  (ref) {
    final modelName = ref.watch(_modelNameProvider);
    return modelName == modelName.pascalCase;
  },
  dependencies: [_modelNameProvider],
);

final _modelClassErrorProvider = Provider.autoDispose<String?>(
  (ref) => ref.watch(_modelClassValidProvider) ? null : 'Model class name must be in PascalCase.',
  dependencies: [_modelClassValidProvider],
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    final collectionName = ref.watch(_collectionNameProvider);
    final modelName = ref.watch(_modelNameProvider);
    final modelClassValid = ref.watch(_modelClassValidProvider);
    return collectionName.isNotEmpty && modelName.isNotEmpty && modelClassValid;
  },
  dependencies: [
    _collectionNameProvider,
    _modelNameProvider,
    _modelClassValidProvider,
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
        _collectionNameProvider.overrideWith((ref) => collection?.name ?? ''),
        _modelNameProvider.overrideWith((ref) => collection?.modelName ?? ''),
      ],
      child: CollectionGetterInitializer(
        collection: inCollection,
        child: AppDialog(
          title: collection == null ? 'Start a collection' : 'Edit ${collection.name} collection',
          content: const _Content(),
          actions: const [
            CancelButton(),
            _SaveButton(),
          ],
        ),
      ),
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
    final collection = ref.watch(collectionGetter);

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
      errorText: ref.watch(_modelClassErrorProvider),
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
              final viewModel = ref.read(configViewModelProvider);
              final collection = viewModel.startCollection(
                inCollection: ref.read(collectionGetter),
                collectionName: ref.read(_collectionNameProvider),
                modelName: ref.read(_modelNameProvider),
              );
              viewModel.selectCollection(collection);
              Navigator.of(context).pop();
            }
          : null,
    );
  }
}
