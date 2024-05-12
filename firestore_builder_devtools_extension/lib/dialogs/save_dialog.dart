import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/cancel_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/save_button.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_dialog.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';

class SaveDialog extends StatelessWidget {
  const SaveDialog({super.key});

  static Future<bool?> show(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => const SaveDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'Save configuration file',
      content: const SectionText('This will overwrite the current configuration file: $defaultConfigFilPath'),
      actions: [
        const CancelButton(),
        SaveButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
