import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';

class NamedInput extends StatelessWidget {
  const NamedInput({
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final String label;
  final String hintText;
  final String? errorText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: AppInput(
        onChanged: onChanged,
        hintText: hintText,
        errorText: errorText,
        labelText: label,
      ),
    );
  }
}

class NamedInputLayout extends StatelessWidget {
  const NamedInputLayout({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionText(title),
        const AppGap.regular(),
        child,
      ],
    );
  }
}
