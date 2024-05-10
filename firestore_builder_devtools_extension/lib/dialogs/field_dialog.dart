import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/extensions/string_extensions.dart';
import 'package:firestore_builder_devtools_extension/models/custom_class_error.dart';
import 'package:firestore_builder_devtools_extension/models/field_name_error.dart';
import 'package:firestore_builder_devtools_extension/models/field_type.dart';
import 'package:firestore_builder_devtools_extension/path/path_value.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
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
import 'package:recase/recase.dart';

final _collectionGetter = Provider<Collection>(
  (ref) => throw Exception('_collectionGetter not found'),
);

final _fieldGetter = Provider<CollectionField?>(
  (ref) => throw Exception('_fieldGetter not found'),
);

final _fieldNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _fieldNameErrorProvider = Provider.autoDispose<FieldNameError?>(
  (ref) {
    final fieldName = ref.watch(_fieldNameProvider);
    final isEmpty = fieldName.isTrimmedEmpty;
    if (isEmpty) {
      return FieldNameErrorEmpty(fieldName);
    }

    final onlyLetters = fieldName.isOnlyLettersWithUnderscore;
    if (!onlyLetters) {
      return FieldNameErrorInvalid(fieldName);
    }

    final collection = ref.watch(_collectionGetter);
    final field = ref.watch(_fieldGetter);
    final otherFields = collection.fields.where((c) => c != field).toList();
    final alreadyExist = otherFields.any((c) => c.fieldName.toLowerCase() == fieldName.toLowerCase());
    if (alreadyExist) {
      return FieldNameErrorAlreadyExists(fieldName);
    }

    return null;
  },
  dependencies: [
    _fieldNameProvider,
    _collectionGetter,
    _fieldGetter,
  ],
);

final _acceptFieldValueProvider = StateProvider.autoDispose<bool>(
  (ref) => throw UnimplementedError(),
);

final _customClassNameProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _customClassNameErrorProvider = Provider.autoDispose<CustomClassNameError?>(
  (ref) {
    final typeMap = ref.watch(_typeMapProvider);
    final hasCustomClass = typeMap.values.any((element) => element.fieldType == FieldTypeEnum.customClass);
    if (!hasCustomClass) {
      return null;
    }

    final customClassName = ref.watch(_customClassNameProvider);
    final isEmpty = customClassName.isTrimmedEmpty;
    if (isEmpty) {
      return CustomClassNameErrorEmpty(customClassName);
    }

    final onlyLetters = customClassName.isOnlyLettersWithUnderscore;
    if (!onlyLetters) {
      return CustomClassNameErrorInvalid(customClassName);
    }

    final field = ref.watch(_fieldGetter);
    final config = ref.watch(configProvider);
    final otherFields = config.allFields.where((f) => f != field).toList();
    final alreadyExist = otherFields.any((f) => f.type.customClassName?.toLowerCase() == customClassName.toLowerCase());
    if (alreadyExist) {
      return CustomClassNameErrorAlreadyExists(customClassName);
    }

    return null;
  },
  dependencies: [
    _typeMapProvider,
    _customClassNameProvider,
    _fieldGetter,
    configProvider,
  ],
);

final _customClassPathProvider = StateProvider.autoDispose<String>(
  (ref) => throw UnimplementedError(),
);

final _customClassPathErrorProvider = Provider.autoDispose<CustomClassPathError?>(
  (ref) {
    final typeMap = ref.watch(_typeMapProvider);
    final hasCustomClass = typeMap.values.any((element) => element.fieldType == FieldTypeEnum.customClass);
    if (!hasCustomClass) {
      return null;
    }

    final customClassPath = ref.watch(_customClassPathProvider);
    final isEmpty = customClassPath.isTrimmedEmpty;
    if (isEmpty) {
      return CustomClassPathErrorEmpty(customClassPath);
    }

    return null;
  },
  dependencies: [
    _typeMapProvider,
    _customClassPathProvider,
  ],
);

final _typeMapProvider = StateProvider.autoDispose<Map<int, FieldTypeNullable>>(
  (ref) => throw UnimplementedError(),
);

final _fieldTypeProvider = Provider.autoDispose<FieldType>(
  (ref) {
    final typeMap = ref.watch(_typeMapProvider);
    final customClassName = ref.watch(_customClassNameProvider);
    final customClassPath = ref.watch(_customClassPathProvider);
    return typeMap.getFieldType(
      level: 0,
      customClassName: customClassName.pascalCase,
      customClassPath: customClassPath,
      config: ref.watch(configProvider),
    );
  },
  dependencies: [
    _typeMapProvider,
    _customClassNameProvider,
    _customClassPathProvider,
  ],
);

final _levelsProvider = Provider.autoDispose<List<int>>(
  (ref) {
    final map = ref.watch(_typeMapProvider);
    return map.keys.toList();
  },
  dependencies: [_typeMapProvider],
);

final _typeProvider = Provider.autoDispose.family<FieldTypeNullable, int>(
  (ref, level) {
    final map = ref.watch(_typeMapProvider);
    return map[level]!;
  },
  dependencies: [_typeMapProvider],
);

final _fieldTypeEnumProvider = Provider.autoDispose.family<FieldTypeEnum, int>(
  (ref, level) {
    final type = ref.watch(_typeProvider(level));
    return type.fieldType;
  },
  dependencies: [_typeProvider],
);

final _isNullableProvider = Provider.autoDispose.family<bool, int>(
  (ref, level) {
    final type = ref.watch(_typeProvider(level));
    return type.nullable;
  },
  dependencies: [_typeProvider],
);

final _canSaveProvider = Provider.autoDispose<bool>(
  (ref) {
    final fieldError = ref.watch(_fieldNameErrorProvider);
    final customClassNameError = ref.watch(_customClassNameErrorProvider);
    final customClassPathError = ref.watch(_customClassPathErrorProvider);
    return fieldError == null && customClassNameError == null && customClassPathError == null;
  },
  dependencies: [
    _fieldNameErrorProvider,
    _customClassNameErrorProvider,
    _customClassPathErrorProvider,
  ],
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

  final Collection collection;
  final CollectionField? field;

  _Mode get _mode {
    return field == null ? _Mode.create : _Mode.edit;
  }

  static Future<void> showCreate({
    required BuildContext context,
    required Collection collection,
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
    required Collection collection,
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
        _fieldGetter.overrideWithValue(field),
        _collectionGetter.overrideWithValue(collection),
        _acceptFieldValueProvider.overrideWith(
          (ref) => field?.acceptFieldValue ?? false,
        ),
        _fieldNameProvider.overrideWith(
          (ref) => field?.name ?? '',
        ),
        _customClassNameProvider.overrideWith(
          (ref) => field?.type.customClassName ?? '',
        ),
        _customClassPathProvider.overrideWith(
          (ref) => field?.type.customClassPath ?? '',
        ),
        _typeMapProvider.overrideWith(
          (ref) => field?.type.getFieldTypeEnumMap(0) ?? {0: defaultFieldTypeNullable},
        ),
      ],
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
        const _AcceptFieldValue(),
        const AppGap.regular(),
        const LabelValueRow(
          label: 'Type:',
          value: _DartType(),
        ),
        const AppGap.semiBig(),
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
    final collection = ref.watch(_collectionGetter);

    return PathValue(
      collection: collection,
    );
  }
}

class _AcceptFieldValue extends ConsumerWidget {
  const _AcceptFieldValue();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acceptFieldValue = ref.watch(_acceptFieldValueProvider);
    return AppSwitch(
      label: 'Accept field value',
      value: acceptFieldValue,
      onChanged: (value) {
        ref.read(_acceptFieldValueProvider.notifier).state = value;
      },
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
      errorText: ref.watch(_fieldNameErrorProvider.select((value) => value?.error)),
      withError: true,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (level != 0)
            _DropdownMenuSizeContainer(
              child: SizedBox(
                width: spacings.regular + level * spacings.extraBig,
                child: DashedLine(
                  dots: 10 * (level + 1),
                ),
              ),
            ),
          Expanded(
            child: _DropDownMenu(
              level: level,
            ),
          ),
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
            );
          return newMap;
        });
      },
    );
  }
}

class _DropdownMenuSizeContainer extends StatelessWidget {
  const _DropdownMenuSizeContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDropdownMenu.height,
      child: Center(
        child: child,
      ),
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
    final showCustomClassPath = initialSelection == FieldTypeEnum.customClass;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppDropdownMenu(
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
            ),
            const AppGap.regular(),
            _DropdownMenuSizeContainer(
              child: _NullableSwitch(level: level),
            ),
          ],
        ),
        if (showCustomClassPath) ...[
          const AppGap.regular(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppInput(
                  initialText: ref.watch(_customClassNameProvider),
                  label: 'Custom class name *',
                  hintText: 'Enter the custom class name',
                  isDense: true,
                  widthFactor: 1,
                  errorText: ref.watch(_customClassNameErrorProvider.select((value) => value?.error)),
                  withError: true,
                  onChanged: (value) {
                    ref.read(_customClassNameProvider.notifier).state = value;
                  },
                ),
              ),
              const AppGap.small(),
              Expanded(
                child: AppInput(
                  initialText: ref.watch(_customClassPathProvider),
                  label: 'Custom class path *',
                  hintText: 'Enter the custom class path',
                  isDense: true,
                  widthFactor: 1,
                  onChanged: (value) {
                    ref.read(_customClassPathProvider.notifier).state = value;
                  },
                ),
              ),
            ],
          ),
        ],
      ],
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

              ref.read(configViewModelProvider).addField(
                    inCollection: collection,
                    fieldName: ref.read(_fieldNameProvider).trim(),
                    type: ref.read(_fieldTypeProvider),
                    acceptFieldValue: ref.read(_acceptFieldValueProvider),
                  );
              Navigator.of(context).pop();
            }
          : null,
    );
  }
}
