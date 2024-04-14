import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
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

class StartCollectionButton extends StatelessWidget {
  const StartCollectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListTile(
      onTap: () async {
        await _StartCollectionDialog.show(context);
      },
      title: const Text('Start collection'),
      selectedColor: colors.primary,
      selectedTileColor: colors.primaryContainer,
      leading: const Icon(Icons.add),
      textColor: colors.primary,
      iconColor: colors.primary,
    );
  }
}

class _StartCollectionDialog extends StatelessWidget {
  const _StartCollectionDialog();

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const _StartCollectionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
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
              ref.read(configViewModelProvider).startCollection(
                    collectionName: ref.read(_collectionNameProvider),
                    modelName: ref.read(_modelNameProvider),
                  );
              Navigator.of(context).pop();
            }
          : null,
      child: const Text('Save'),
    );
  }
}
