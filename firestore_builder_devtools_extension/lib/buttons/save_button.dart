import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    this.onPressed,
    super.key,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Save'),
    );
  }
}
