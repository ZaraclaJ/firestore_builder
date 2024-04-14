import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    this.onChanged,
    this.hintText,
    this.errorText,
    super.key,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: errorText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colors.error,
          ),
        ),
      ),
    );
  }
}
