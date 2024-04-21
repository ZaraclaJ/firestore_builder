import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton.primary({
    required this.text,
    this.onPressed,
    super.key,
    this.isDestructive = false,
  })  : _outlined = true,
        _elevated = true;

  const AppButton.secondary({
    required this.text,
    this.onPressed,
    super.key,
  })  : _outlined = true,
        _elevated = false,
        isDestructive = false;

  const AppButton.tertiary({
    required this.text,
    this.onPressed,
    super.key,
  })  : _outlined = false,
        _elevated = false,
        isDestructive = false;

  final void Function()? onPressed;
  final String text;
  final bool _outlined;
  final bool _elevated;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Theme(
      data: isDestructive
          ? theme.copyWith(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.error,
                  foregroundColor: context.colors.onError,
                ),
              ),
            )
          : theme,
      child: DevToolsButton(
        elevated: _elevated,
        outlined: _outlined,
        label: text,
        onPressed: onPressed,
      ),
    );
  }
}
