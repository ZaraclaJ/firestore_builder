import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

class SectionText extends StatelessWidget {
  const SectionText(this.text, {this.color, super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final styleBase = context.typos.titleMedium;
    final style = color != null ? styleBase?.copyWith(color: color) : styleBase;
    return Text(text, style: style);
  }
}
