import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/models/field_type.dart';
import 'package:firestore_builder_devtools_extension/path/path_value.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dropdown_menu.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_switch.dart';
import 'package:firestore_builder_devtools_extension/widgets/dashed_line.dart';
import 'package:firestore_builder_devtools_extension/widgets/label_value_row.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _fieldNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _typeMapProvider = StateProvider.autoDispose<Map<int, FieldTypeNullable>>(
  (ref) => throw UnimplementedError(),
);

final _fieldTypeProvider = Provider.autoDispose<FieldType>(
  (ref) {
    return ref.watch(_typeMapProvider).getFieldType(0);
  },
  dependencies: [_typeMapProvider],
);

final _levelsProvider = Provider.autoDispose<List<int>>(
  (ref) {
    final map = ref.watch(_typeMapProvider);
    return map.keys.toList();
  },
  dependencies: [_typeMapProvider],
);

final _typeProvider = Provider.autoDispose.family<FieldTypeNullable?, int>(
  (ref, level) {
    final map = ref.watch(_typeMapProvider);
    return map[level];
  },
  dependencies: [_typeMapProvider],
);

final _fieldTypeEnumProvider = Provider.autoDispose.family<FieldTypeEnum?, int>(
  (ref, level) {
    final type = ref.watch(_typeProvider(level));
    return type?.fieldType;
  },
  dependencies: [_typeProvider],
);

final _isNullableProvider = Provider.autoDispose.family<bool, int>(
  (ref, level) {
    final type = ref.watch(_typeProvider(level));
    return type?.nullable ?? false;
  },
  dependencies: [_typeProvider],
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    final hasName = ref.watch(_fieldNameProvider).isNotEmpty;
    return hasName;
  },
  dependencies: [_fieldNameProvider],
);

enum _Mode {
  create,
  edit,
}

class FieldDialog extends StatelessWidget {
  const FieldDialog({
    required this.collection,
    required this.field,
    super.key,
  });

  final Collection? collection;
  final CollectionField? field;

  _Mode get _mode {
    return field == null ? _Mode.create : _Mode.edit;
  }

  static Future<void> showCreate({
    required BuildContext context,
    required Collection? collection,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FieldDialog(
          collection: collection,
          field: null,
        );
      },
    );
  }

  static Future<void> showEdit({
    required BuildContext context,
    required Collection? collection,
    required CollectionField field,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return FieldDialog(
          collection: collection,
          field: field,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        _fieldNameProvider.overrideWith(
          (ref) => field?.name ?? '',
        ),
        _typeMapProvider.overrideWith(
          (ref) => field?.type.getFieldTypeEnumMap(0) ?? {0: defaultFieldTypeNullable},
        ),
      ],
      child: CollectionGetterInitializer(
        collection: collection,
        child: AppDialog(
          title: switch (_mode) {
            _Mode.create => 'Add a field',
            _Mode.edit => 'Edit a field',
          },
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
    final levels = ref.watch(_levelsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const LabelValueRow(
          label: 'Collection:',
          value: _Path(),
        ),
        const AppGap.regular(),
        const LabelValueRow(
          label: 'Type:',
          value: _DartType(),
        ),
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

class _DartType extends ConsumerWidget {
  const _DartType();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final symbolName = ref.watch(_fieldTypeProvider).typeReference.symbolName;
    return SectionText(
      symbolName,
      color: context.colors.primary,
    );
  }
}

class _NameInput extends ConsumerWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppInput(
      initialText: ref.watch(_fieldNameProvider),
      label: 'Field name',
      hintText: 'Enter the field name',
      onChanged: (value) {
        ref.read(_fieldNameProvider.notifier).state = value;
      },
    );
  }
}

class _TypeInput extends StatelessWidget {
  const _TypeInput({
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context) {
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
          _DropDownMenu(
            level: level,
          ),
          const AppGap.regular(),
          _NullableSwitch(level: level),
        ],
      ),
    );
  }
}

class _NullableSwitch extends ConsumerWidget {
  const _NullableSwitch({required this.level});

  final int level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNullable = ref.watch(_isNullableProvider(level));

    return AppSwitch(
      label: 'Nullable',
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
    );
  }
}

class _DropDownMenu extends ConsumerWidget {
  const _DropDownMenu({
    required this.level,
  });

  final int level;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNullable = ref.watch(_isNullableProvider(level));
    final initialSelection = ref.watch(_fieldTypeEnumProvider(level));

    return AppDropdownMenu(
      initialSelection: initialSelection,
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
              final collection = ref.read(collectionGetter);
              if (collection == null) {
                return;
              }

              ref.read(configViewModelProvider).addField(
                    inCollection: collection,
                    fieldName: ref.read(_fieldNameProvider),
                    type: ref.read(_fieldTypeProvider),
                    // TODO(Jordan): : implement
                    acceptFieldValue: false,
                  );
              Navigator.of(context).pop();
            }
          : null,
    );
  }
}
