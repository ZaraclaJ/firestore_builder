import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton.primary({
    required this.text,
    super.key,
    this.onPressed,
  })  : _outlined = true,
        _elevated = true;

  const AppButton.secondary({
    required this.text,
    super.key,
    this.onPressed,
  })  : _outlined = true,
        _elevated = false;

  const AppButton.tertiary({
    required this.text,
    super.key,
    this.onPressed,
  })  : _outlined = false,
        _elevated = false;

  final void Function()? onPressed;
  final String text;
  final bool _outlined;
  final bool _elevated;

  @override
  Widget build(BuildContext context) {
    return DevToolsButton(
      elevated: _elevated,
      outlined: _outlined,
      label: text,
      onPressed: onPressed,
    );
  }
}
