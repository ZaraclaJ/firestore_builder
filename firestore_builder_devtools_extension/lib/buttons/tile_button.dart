import 'package:firestore_builder_devtools_extension/widgets/app_list_tile.dart';
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
    return AppListTile(
      onTap: onTap,
      title: text,
      leading: Icon(_icon),
    );
  }
}
