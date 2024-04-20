import 'package:firestore_builder_devtools_extension/widgets/app_button.dart';
import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton.tertiary(
      onPressed: () {
        Navigator.of(context).pop();
      },
      text: 'Cancel',
    );
  }
}
