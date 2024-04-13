import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:flutter/material.dart';

class StartCollectionButton extends StatelessWidget {
  const StartCollectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ListTile(
      onTap: () async {
        await _StartCollectionDialog.show(context);
      },
      title: const Text('Start collection'),
      selectedColor: colors.primary,
      selectedTileColor: colors.primaryContainer,
      leading: const Icon(Icons.add),
      textColor: colors.primary,
      iconColor: colors.primary,
    );
  }
}

class _StartCollectionDialog extends StatelessWidget {
  const _StartCollectionDialog();

  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const _StartCollectionDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AlertDialog(
      title: const Text('Start a collection'),
      content: SizedBox(
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Parent path'),
            const AppGap.regular(),
            const Text('/'),
            const AppGap.semiBig(),
            const Text('Collection ID'),
            const AppGap.regular(),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter a collection ID',
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
                ),
              ),
            ),
            const AppGap.semiBig(),
            const AppDivider.horizontal(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
