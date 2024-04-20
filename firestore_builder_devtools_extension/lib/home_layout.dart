import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/collections/collections_bloc.dart';
import 'package:firestore_builder_devtools_extension/extensions/num_extensions.dart';
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
        _FirebaseConfigLayout(),
        SizedBox(),
      ],
    );
  }
}

class _FirebaseConfigLayout extends StatelessWidget {
  const _FirebaseConfigLayout();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.bounded(minWidth, maxWidth);
        final height = constraints.maxHeight.bounded(minHeight, maxHeight);
        return InteractiveViewer(
          constrained: false,
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: const Column(
                children: [
                  Expanded(child: CollectionsBloc()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
