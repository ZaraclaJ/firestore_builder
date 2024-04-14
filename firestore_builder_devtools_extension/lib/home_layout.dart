import 'dart:math';

import 'package:firestore_builder_devtools_extension/collections/collections_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = min<double>(constraints.maxWidth, 1350);
        final height = max<double>(constraints.maxHeight, 600);
        return SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: const _Layout(),
            ),
          ),
        );
      },
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(child: CollectionsBloc()),
      ],
    );
  }
}
