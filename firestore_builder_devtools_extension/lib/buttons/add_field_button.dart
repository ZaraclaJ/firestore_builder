import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/tile_button.dart';
import 'package:firestore_builder_devtools_extension/path/path_text.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/named_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum _FieldTypeEnum {
  string,
  int,
  double,
  bool,
  timestamp,
  dateTime,
  documentReference,
  list,
  map,
  customClass,
}

final _selectedTypeProvider = StateProvider.autoDispose<_FieldTypeEnum?>(
  (ref) => null,
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    return true;
  },
);

class AddFieldButton extends ConsumerWidget {
  const AddFieldButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TileButton.add(
      text: 'Add field',
      onTap: () async {
        final collection = ref.read(collectionGetter);
        await _CreateFieldDialog.show(
          context: context,
          collection: collection,
        );
      },
    );
  }
}

class _CreateFieldDialog extends StatelessWidget {
  const _CreateFieldDialog({required this.collection});

  final Collection? collection;

  static Future<void> show({
    required BuildContext context,
    required Collection? collection,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return _CreateFieldDialog(
          collection: collection,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CollectionGetterInitializer(
      collection: collection,
      child: const AppDialog(
        title: 'Add a field',
        content: _Content(),
        actions: [
          CancelButton(),
          _SaveButton(),
        ],
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionGetter);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Parent path'),
        const AppGap.regular(),
        PathText(collection: collection),
        const AppGap.regular(),
        const _NameInput(),
        const AppGap.regular(),
        const _TypeInput(),
      ],
    );
  }
}

class _NameInput extends ConsumerWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NamedInput(
      title: 'Field name',
      hintText: 'Enter the field name',
      onChanged: (value) {},
    );
  }
}

class _TypeInput extends ConsumerWidget {
  const _TypeInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NamedDropdownMenu(
      title: 'Field type',
      entries: _FieldTypeEnum.values.map((e) {
        return DropdownMenuEntry(
          value: e,
          label: e.name,
        );
      }).toList(),
      onSelected: (type) {
        ref.read(_selectedTypeProvider.notifier).state = type;
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
              Navigator.of(context).pop();
            }
          : null,
    );
  }
}
