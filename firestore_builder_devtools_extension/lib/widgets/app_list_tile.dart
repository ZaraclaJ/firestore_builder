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
    this.titleColor,
    super.key,
  });

  final void Function()? onTap;
  final String? title;
  final Widget? titleWidget;
  final bool selected;
  final Widget? leading;
  final Widget? trailing;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        dense: true,
        selected: selected,
        title: titleWidget ??
            AppListTileTitleText(
              title ?? '',
              color: titleColor,
            ),
        leading: leading,
        trailing: trailing,
        textColor: colors.primary,
        selectedColor: colors.primary,
        selectedTileColor: colors.primaryContainer,
        iconColor: colors.primary,
        tileColor: colors.surface,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: colors.primaryContainer.withOpacity(0.1),
      ),
    );
  }
}

class AppListTileTitleText extends StatelessWidget {
  const AppListTileTitleText(
    this.title, {
    this.color,
    super.key,
  });

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.typos.bodyLarge?.copyWith(color: color ?? context.colors.primary),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
