import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/layouts/code_layout/code_layout.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/firebase_config_layout.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    required this.onSave,
    super.key,
  });

  final void Function() onSave;

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
        Align(
          child: _SaveButton(onSave: onSave),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.onSave});

  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      text: 'Save config file',
      onPressed: onSave,
    );
  }
}
