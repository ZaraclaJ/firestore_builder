import 'package:devtools_app_shared/ui.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.label,
    required this.value,
    this.message,
    this.onChanged,
    super.key,
  });

  final String label;
  final bool value;
  final void Function(bool value)? onChanged;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return DevToolsToggleButton(
      isSelected: value,
      message: message ?? '',
      icon: value ? Icons.check : Icons.close,
      label: label,
      onPressed: () {
        onChanged?.call(!value);
      },
    );
  }
}
