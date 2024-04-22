import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/field_dialog.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_list_tile.dart';
import 'package:firestore_builder_devtools_extension/widgets/confirmation_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/on_hover_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FieldList extends ConsumerWidget {
  const FieldList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = ref.watch(collectionGetter)?.fields ?? [];
    return Material(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: fields.length,
        itemBuilder: (BuildContext context, int index) {
          final field = fields[index];
          return _FieldItem(
            field: field,
          );
        },
      ),
    );
  }
}

class _FieldItem extends StatelessWidget {
  const _FieldItem({required this.field});

  final CollectionField field;

  @override
  Widget build(BuildContext context) {
    return OnHoverBuilder(
      builder: (onHover) {
        return AppListTile(
          onTap: () {},
          title: '${field.name}: ${field.type.typeReference.symbolName}',
          titleWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${field.name}:'),
              const AppGap.small(),
              Expanded(
                child: Text(
                  field.type.typeReference.symbolName,
                  style: context.typos.labelLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onHover) ...[
                const AppGap.regular(),
                _EditButton(
                  field: field,
                ),
                const AppGap.regular(),
                _DeleteButton(
                  field: field,
                ),
              ] else
                const SizedBox(
                  height: _Button.iconSize,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _EditButton extends ConsumerWidget {
  const _EditButton({
    required this.field,
  });

  final CollectionField field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Button(
      icon: Icons.edit,
      tooltip: 'Edit field',
      onTap: () {
        final collection = ref.read(collectionGetter);
        if (collection == null) {
          return;
        }

        FieldDialog.showEdit(
          context: context,
          collection: collection,
          field: field,
        );
      },
    );
  }
}

class _DeleteButton extends ConsumerWidget {
  const _DeleteButton({
    required this.field,
  });

  final CollectionField field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _Button(
      icon: Icons.delete,
      tooltip: 'Delete field',
      color: context.colors.error,
      onTap: () async {
        final collection = ref.read(collectionGetter);
        if (collection == null) {
          return;
        }

        final viewModel = ref.read(configViewModelProvider);
        final confirm = await ConfirmationDialog.show(
          context: context,
          title: 'Delete field',
          description: 'Are you sure you want to delete this field?',
          validateLabel: 'Delete',
          isDestructive: true,
        );

        if (confirm != null && confirm) {
          viewModel.removeField(
            inCollection: collection,
            field: field,
          );
        }
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.color,
  });

  final IconData icon;
  final void Function() onTap;
  final String? tooltip;
  final Color? color;

  static const double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox.square(
          dimension: iconSize,
          child: AppPadding.small(
            child: FittedBox(
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
