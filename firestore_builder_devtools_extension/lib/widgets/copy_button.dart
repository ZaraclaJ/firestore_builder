import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return DevToolsButton.iconOnly(
      icon: Icons.copy,
      tooltip: 'Copy',
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text(
              'Copied to clipboard',
              style: context.typos.bodyMedium?.copyWith(color: context.colors.onSurface),
            ),
            backgroundColor: context.colors.surfaceContainer,
          ),
        );
      },
    );
  }
}
