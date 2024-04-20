import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    this.onChanged,
    this.labelText,
    this.hintText,
    this.errorText,
    super.key,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textStyle = theme.regularTextStyle;

    return TextField(
      onChanged: onChanged,
      style: textStyle,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(denseSpacing),
        isDense: false,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: theme.focusColor),
        ),
        labelText: labelText,
        labelStyle: textStyle,
        hintText: hintText,
        hintStyle: textStyle,
        errorText: errorText,
      ),
    );
  }
}
