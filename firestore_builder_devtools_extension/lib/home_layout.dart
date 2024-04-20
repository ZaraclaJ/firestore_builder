import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/layouts/code_layout/code_layout.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/firebase_config_layout.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Split(
      initialFractions: const [1 - codeFraction, codeFraction],
      minSizes: const [0, 0],
      axis: Axis.horizontal,
      children: const [
        FirebaseConfigLayout(),
        CodeLayout(),
      ],
    );
  }
}
