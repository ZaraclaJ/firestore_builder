import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    this.onChanged,
    this.label,
    this.hintText,
    this.errorText,
    this.widthFactor = 0.7,
    this.isDense = false,
    this.withError = false,
    this.initialText,
    super.key,
  });

  final void Function(String)? onChanged;
  final String? hintText;
  final String? label;
  final String? errorText;
  final double widthFactor;
  final bool isDense;
  final String? initialText;
  final bool withError;

  static const double denseHeightWithError = 48;
  static const double heightWithError = 72;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textStyle = theme.regularTextStyle;

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: _ControllerBuilder(
        initialText: initialText,
        builder: (controller) {
          return SizedBox(
            height: switch ((isDense, withError)) {
              (_, false) => null,
              (true, true) => denseHeightWithError,
              (false, true) => heightWithError,
            },
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: textStyle,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(denseSpacing),
                isDense: isDense,
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: theme.focusColor),
                ),
                labelText: label,
                labelStyle: textStyle,
                hintText: hintText,
                hintStyle: textStyle,
                errorText: errorText,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ControllerBuilder extends StatefulWidget {
  const _ControllerBuilder({
    required this.builder,
    required this.initialText,
  });

  final Widget Function(TextEditingController controller) builder;
  final String? initialText;

  @override
  State<_ControllerBuilder> createState() => _ControllerBuilderState();
}

class _ControllerBuilderState extends State<_ControllerBuilder> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialText,
    );
  }

  @override
  void didUpdateWidget(covariant _ControllerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialText != widget.initialText && widget.initialText != _controller.text) {
      setState(() {
        _controller.text = widget.initialText ?? '';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_controller);
  }
}
