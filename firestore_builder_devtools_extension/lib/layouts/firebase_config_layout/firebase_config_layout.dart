import 'package:firestore_builder_devtools_extension/extensions/num_extensions.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/collections_bloc.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/widgets/double_scroll_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseConfigLayout extends StatelessWidget {
  const FirebaseConfigLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.bounded(minWidth, maxWidth);
        final height = constraints.maxHeight.bounded(minHeight, maxHeight);
        return DoubleScrollLayout(
          child: SizedBox(
            width: width,
            height: height,
            child: const Column(
              children: [
                Expanded(child: CollectionsBloc()),
              ],
            ),
          ),
        );
      },
    );
  }
}
