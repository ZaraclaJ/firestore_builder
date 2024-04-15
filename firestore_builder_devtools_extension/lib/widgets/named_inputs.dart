import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dropdown_menu.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:flutter/material.dart';

class NamedInput extends StatelessWidget {
  const NamedInput({
    required this.title,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final String title;
  final String hintText;
  final String? errorText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return _Layout(
      title: title,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: AppInput(
          onChanged: onChanged,
          hintText: hintText,
          errorText: errorText,
        ),
      ),
    );
  }
}

class NamedDropdownMenu<T> extends StatelessWidget {
  const NamedDropdownMenu({
    required this.title,
    required this.entries,
    this.onSelected,
    super.key,
  });

  final String title;
  final List<DropdownMenuEntry<T>> entries;
  final void Function(T?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return _Layout(
      title: title,
      child: AppDropdownMenu<T>(
        onSelected: onSelected,
        entries: entries,
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: context.typos.titleMedium),
        const AppGap.regular(),
        child,
      ],
    );
  }
}
