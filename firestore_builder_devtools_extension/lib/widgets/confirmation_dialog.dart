import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_button.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog._({
    required this.title,
    required this.description,
    required this.validateLabel,
    required this.isDestructive,
  });

  final String title;
  final String description;
  final String? validateLabel;

  final bool isDestructive;

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String description,
    bool isDestructive = false,
    String? validateLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return ConfirmationDialog._(
          title: title,
          description: description,
          validateLabel: validateLabel,
          isDestructive: isDestructive,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      titleColor: isDestructive ? context.colors.error : null,
      content: Text(description, style: context.typos.bodyLarge),
      actions: [
        AppButton.tertiary(
          onPressed: () => Navigator.of(context).pop(false),
          text: 'Cancel',
        ),
        AppButton.primary(
          onPressed: () => Navigator.of(context).pop(true),
          text: validateLabel ?? 'Confirm',
          isDestructive: isDestructive,
        ),
      ],
    );
  }
}
