import 'package:firestore_builder_devtools_extension/widgets/app_button.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      onPressed: onPressed,
      text: 'Save',
    );
  }
}
