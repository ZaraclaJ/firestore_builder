import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/layouts/code_layout/code_layout.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/firebase_config_layout.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    required this.onSaveConfig,
    super.key,
  });

  final void Function() onSaveConfig;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton.primary(
              text: 'Save config file',
              onPressed: onSaveConfig,
            ),
            const AppGap.big(),
          ],
        ),
      ],
    );
  }
}
