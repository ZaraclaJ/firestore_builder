import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.content,
    super.key,
    this.actions,
  });

  final String title;
  final Widget content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return DevToolsDialog(
      title: Text(title, style: context.typos.titleLarge),
      content: SizedBox(
        width: 600,
        child: content,
      ),
      actions: actions,
    );
  }
}
