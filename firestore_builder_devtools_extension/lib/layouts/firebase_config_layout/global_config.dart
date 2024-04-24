import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_input.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalConfig extends StatelessWidget {
  const GlobalConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPadding.semiBig(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectName(),
          AppGap.regular(),
          _OutputPath(),
          AppGap.regular(),
          _Clear(),
        ],
      ),
    );
  }
}

class _ProjectName extends ConsumerWidget {
  const _ProjectName();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectName = ref.watch(configProvider.select((value) => value.projectName));
    return AppInput(
      label: 'Project name *',
      hintText: 'Enter the name of the project',
      onChanged: (value) {
        ref.read(configViewModelProvider).updateProjectName(value);
      },
      isDense: true,
      widthFactor: 0.5,
      initialText: projectName,
    );
  }
}

class _OutputPath extends ConsumerWidget {
  const _OutputPath();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outputPath = ref.watch(configProvider.select((value) => value.outputPath));
    return AppInput(
      label: 'Output path *',
      hintText: 'Where the code will be generated',
      onChanged: (value) {
        ref.read(configViewModelProvider).updateOutputPath(value);
      },
      isDense: true,
      widthFactor: 0.5,
      initialText: outputPath,
    );
  }
}

class _Clear extends ConsumerWidget {
  const _Clear();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clear = ref.watch(configProvider.select((value) => value.clear));
    return AppSwitch(
      label: 'Clear',
      onChanged: (value) {
        ref.read(configViewModelProvider).updateClear(value);
      },
      value: clear,
    );
  }
}
