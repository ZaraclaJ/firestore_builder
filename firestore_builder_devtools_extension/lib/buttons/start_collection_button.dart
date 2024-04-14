import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/tile_button.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

final _collectionNameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final _modelNameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final _modelClassValidProvider = Provider.autoDispose<bool>(
  (ref) {
    final modelName = ref.watch(_modelNameProvider);
    return modelName == modelName.pascalCase;
  },
);

final _modelClassErrorProvider = Provider.autoDispose<String?>(
  (ref) => ref.watch(_modelClassValidProvider) ? null : 'Model class name must be in PascalCase.',
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    final collectionName = ref.watch(_collectionNameProvider);
    final modelName = ref.watch(_modelNameProvider);
    final modelClassValid = ref.watch(_modelClassValidProvider);
    return collectionName.isNotEmpty && modelName.isNotEmpty && modelClassValid;
  },
);

class StartCollectionButton extends ConsumerWidget {
  const StartCollectionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TileButton.add(
      text: 'Start collection',
      onTap: () async {
        final collection = ref.read(collectionGetter);
        await _StartCollectionDialog.show(
          context: context,
          collection: collection,
        );
      },
    );
  }
}

class _StartCollectionDialog extends StatelessWidget {
  const _StartCollectionDialog({required this.collection});

  static Future<void> show({
    required BuildContext context,
    required Collection? collection,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _StartCollectionDialog(
          collection: collection,
        );
      },
    );
  }

  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    return CollectionGetterInitializer(
      collection: collection,
      child: const DevToolsDialog(
        title: Text('Start a collection'),
        content: SizedBox(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Parent path'),
              AppGap.regular(),
              Text('/'),
              AppGap.semiBig(),
              _CollectionNameInput(),
              AppGap.semiBig(),
              _ModelNameInput(),
              AppGap.semiBig(),
              AppDivider.horizontal(),
            ],
          ),
        ),
        actions: [
          _CancelButton(),
          _SaveButton(),
        ],
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.title,
    required this.hintText,
    required this.onChanged,
    this.errorText,
  });

  final String title;
  final String hintText;
  final String? errorText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const AppGap.regular(),
        FractionallySizedBox(
          widthFactor: 0.7,
          child: AppInput(
            onChanged: onChanged,
            hintText: hintText,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}

class _CollectionNameInput extends ConsumerWidget {
  const _CollectionNameInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Input(
      title: 'Collection ID',
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
    return _Input(
      title: 'Model class name',
      hintText: 'Enter the name of the model class',
      errorText: ref.watch(_modelClassErrorProvider),
      onChanged: (value) {
        ref.read(_modelNameProvider.notifier).state = value;
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Cancel'),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSave = ref.watch(_canSaveProvider);
    return ElevatedButton(
      onPressed: canSave
          ? () {
              final collection = ref.read(configViewModelProvider).startCollection(
                    inCollection: ref.read(collectionGetter),
                    collectionName: ref.read(_collectionNameProvider),
                    modelName: ref.read(_modelNameProvider),
                  );
              ref.read(selectedCollectionProvider.notifier).state = collection;
              Navigator.of(context).pop();
            }
          : null,
      child: const Text('Save'),
    );
  }
}
