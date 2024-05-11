import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/layouts/code_layout/code_layout.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/firebase_config_layout.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    required this.initialConfig,
    super.key,
  });

  final YamlConfig? initialConfig;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        configProvider.overrideWith(
          (ref) =>
              initialConfig ??
              const YamlConfig(
                projectName: '',
                outputPath: 'lib/firestore',
                clearOutputFolder: true,
                useRiverpod: false,
                collections: [],
              ),
        ),
      ],
      child: SplitPane(
        initialFractions: const [1 - codeFraction, codeFraction],
        minSizes: const [0, 0],
        axis: Axis.horizontal,
        children: const [
          FirebaseConfigLayout(),
          CodeLayout(),
        ],
      ),
    );
  }
}
