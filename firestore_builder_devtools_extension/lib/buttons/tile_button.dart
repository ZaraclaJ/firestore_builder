import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  const TileButton.add({
    required this.text,
    super.key,
    this.onTap,
  }) : _icon = Icons.add;

  const TileButton.remove({
    required this.text,
    super.key,
    this.onTap,
  }) : _icon = Icons.delete;

  final void Function()? onTap;
  final String text;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListTile(
      onTap: onTap,
      title: Text(text),
      selectedColor: colors.primary,
      selectedTileColor: colors.primaryContainer,
      leading: Icon(_icon),
      textColor: colors.primary,
      iconColor: colors.primary,
    );
  }
}
