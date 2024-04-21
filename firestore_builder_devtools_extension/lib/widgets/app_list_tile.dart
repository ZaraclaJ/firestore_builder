import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    this.title,
    this.titleWidget,
    this.selected = false,
    this.onTap,
    this.leading,
    this.trailing,
    super.key,
  });

  final void Function()? onTap;
  final String? title;
  final Widget? titleWidget;
  final bool selected;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      child: ListTile(
        onTap: onTap,
        dense: true,
        selected: selected,
        title: titleWidget ?? Text(title ?? ''),
        leading: leading,
        trailing: trailing,
        textColor: colors.primary,
        selectedColor: colors.primary,
        selectedTileColor: colors.primaryContainer,
        iconColor: colors.primary,
        tileColor: colors.surface,
      ),
    );
  }
}
