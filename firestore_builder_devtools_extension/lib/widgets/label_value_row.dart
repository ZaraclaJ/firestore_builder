import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';

class LabelValueRow extends StatelessWidget {
  const LabelValueRow({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SectionText(
          label,
        ),
        const AppGap.regular(),
        Expanded(
          child: value,
        ),
      ],
    );
  }
}
