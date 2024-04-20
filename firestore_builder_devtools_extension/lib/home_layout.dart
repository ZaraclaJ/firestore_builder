import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/collections/collections_bloc.dart';
import 'package:firestore_builder_devtools_extension/extensions/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const double _codeFraction = 0.3;

const double _minWidth = 500;
const double _maxWidth = 1350;

const double _minHeight = 600;
const double _maxHeight = 1200;

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Split(
      initialFractions: const [1 - _codeFraction, _codeFraction],
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
        final width = constraints.maxWidth.bounded(_minWidth, _maxWidth);
        final height = constraints.maxHeight.bounded(_minHeight, _maxHeight);
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
