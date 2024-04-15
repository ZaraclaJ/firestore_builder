import 'package:flutter/material.dart';

class AppDropdownMenu<T> extends StatelessWidget {
  const AppDropdownMenu({
    required this.entries,
    this.onSelected,
    super.key,
  });

  final List<DropdownMenuEntry<T>> entries;
  final void Function(T?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      dropdownMenuEntries: entries,
      onSelected: onSelected,
    );
  }
}
