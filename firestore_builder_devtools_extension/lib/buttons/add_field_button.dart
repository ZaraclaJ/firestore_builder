import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/tile_button.dart';
import 'package:firestore_builder_devtools_extension/models/field_type.dart';
import 'package:firestore_builder_devtools_extension/path/path_text.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dropdown_menu.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_switch.dart';
import 'package:firestore_builder_devtools_extension/widgets/dashed_line.dart';
import 'package:firestore_builder_devtools_extension/widgets/named_inputs.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _fieldNameProvider = StateProvider<String>(
  (ref) => '',
);

final _typeMapProvider = StateProvider.autoDispose<Map<int, FieldTypeNullable>>(
  (ref) => {
    0: defaultFieldTypeNullable,
  },
);

final _fieldTypeProvider = Provider.autoDispose<FieldType>(
  (ref) {
    return ref.watch(_typeMapProvider).getFieldType(0);
  },
);

final _levelsProvider = Provider.autoDispose<List<int>>(
  (ref) {
    final map = ref.watch(_typeMapProvider);
    return map.keys.toList();
  },
);

final _typeProvider = Provider.autoDispose.family<FieldTypeNullable?, int>(
  (ref, level) {
    final map = ref.watch(_typeMapProvider);
    return map[level];
  },
);

final _fieldTypeEnumProvider = Provider.autoDispose.family<FieldTypeEnum?, int>(
  (ref, level) {
    final type = ref.watch(_typeProvider(level));
    return type?.fieldType;
  },
);

final _isNullableProvider = Provider.autoDispose.family<bool, int>(
  (ref, level) {
    final type = ref.watch(_typeProvider(level));
    return type?.nullable ?? false;
  },
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    final hasName = ref.watch(_fieldNameProvider).isNotEmpty;
    return hasName;
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
    final levels = ref.watch(_levelsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SectionText('Parent path'),
        const AppGap.regular(),
        PathText(collection: collection),
        const SectionText('Type'),
        const AppGap.regular(),
        const _DartType(),
        const AppGap.regular(),
        const _NameInput(),
        const AppGap.regular(),
        const SectionText('Field type'),
        const AppGap.regular(),
        for (final level in levels) ...[
          const AppGap.small(),
          _TypeInput(level: level),
        ],
      ],
    );
  }
}

class _DartType extends ConsumerWidget {
  const _DartType();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbolName = ref.watch(_fieldTypeProvider).typeReference.symbolName;
    return Text(
      symbolName,
      style: context.typos.labelLarge?.copyWith(
        color: context.colors.primary,
      ),
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
      onChanged: (value) {
        ref.read(_fieldNameProvider.notifier).state = value;
      },
    );
  }
}

class _TypeInput extends ConsumerWidget {
  const _TypeInput({
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNullable = ref.watch(_isNullableProvider(level));
    final spacings = context.spacings;

    return IntrinsicHeight(
      child: Row(
        children: [
          if (level != 0)
            SizedBox(
              width: spacings.regular + level * spacings.extraBig,
              child: DashedLine(
                dots: 10 * (level + 1),
              ),
            ),
          AppDropdownMenu(
            initialSelection: ref.watch(_fieldTypeEnumProvider(level)),
            entries: FieldTypeEnum.values.map((e) {
              return DropdownMenuEntry(
                value: e,
                label: e.name,
              );
            }).toList(),
            onSelected: (type) {
              if (type == null) {
                return;
              }

              ref.read(_typeMapProvider.notifier).update((map) {
                final newMap = Map<int, FieldTypeNullable>.from(map);

                final hasSubType = type.hasSubType;
                newMap[level] = (
                  fieldType: type,
                  nullable: isNullable,
                );
                if (hasSubType) {
                  newMap[level + 1] = defaultFieldTypeNullable;
                } else {
                  newMap.removeWhere(
                    (key, value) => key > level,
                  );
                }

                return newMap;
              });
            },
          ),
          const AppGap.regular(),
          const Text('Nullable :'),
          const AppGap.small(),
          AppSwitch(
            value: isNullable,
            onChanged: (bool value) {
              ref.read(_typeMapProvider.notifier).update((map) {
                final newMap = Map<int, FieldTypeNullable>.from(map)
                  ..update(
                    level,
                    (fieldTypeNullable) => (
                      fieldType: fieldTypeNullable.fieldType,
                      nullable: value,
                    ),
                    // ifAbsent: () => (fieldType: null, nullable: value),
                  );
                return newMap;
              });
            },
          ),
        ],
      ),
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
