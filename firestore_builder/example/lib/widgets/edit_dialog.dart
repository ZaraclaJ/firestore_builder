import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({
    required this.title,
    required this.initialText,
    required this.onValidate,
    super.key,
  });

  final String title;
  final String initialText;
  final Future<void> Function(String value) onValidate;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String initialText,
    required Future<void> Function(String value) onValidate,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return EditDialog(
          title: title,
          initialText: initialText,
          onValidate: onValidate,
        );
      },
    );
  }

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, text, child) {
            final value = text.text;
            return ElevatedButton(
              onPressed: () {
                widget.onValidate(value);
                Navigator.of(context).pop();
              },
              child: const Text('Validate'),
            );
          },
        ),
      ],
    );
  }
}
