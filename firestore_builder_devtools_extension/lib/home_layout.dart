import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/layouts/code_layout/code_layout.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/firebase_config_layout.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_button.dart';
import 'package:firestore_builder_devtools_extension/widgets/code_view.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    required this.onSaveConfig,
    super.key,
  });

  final void Function() onSaveConfig;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionText('1. Configure your Firestore database structure:'),
        const AppGap.regular(),
        Expanded(
          child: SplitPane(
            initialFractions: const [1 - codeFraction, codeFraction],
            minSizes: const [0, 0],
            axis: Axis.horizontal,
            children: const [
              FirebaseConfigLayout(),
              CodeLayout(),
            ],
          ),
        ),
        const AppGap.regular(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SectionText('2. Save your configuration file: '),
            const AppGap.regular(),
            AppButton.primary(
              text: 'Save config file',
              onPressed: onSaveConfig,
            ),
          ],
        ),
        const AppGap.regular(),
        const SectionText('3. Run the generation command line in your root project folder:'),
        const CodeView(code: 'dart run firestore_builder'),
        const AppGap.regular(),
        const SectionText('4. Run the build runner command to generate Freezed classes:'),
        const CodeView(code: 'dart run build_runner build --delete-conflicting-outputs'),
      ],
    );
  }
}
