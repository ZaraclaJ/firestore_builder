import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title,
    this.selected = false,
    this.onTap,
    this.leading,
    this.trailing,
    super.key,
  });

  final void Function()? onTap;
  final String title;
  final bool selected;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListTile(
      onTap: onTap,
      selected: selected,
      title: Text(title),
      leading: leading,
      trailing: trailing,
      textColor: colors.primary,
      selectedColor: colors.primary,
      selectedTileColor: colors.primaryContainer,
      iconColor: colors.primary,
      tileColor: colors.surface,
    );
  }
}
