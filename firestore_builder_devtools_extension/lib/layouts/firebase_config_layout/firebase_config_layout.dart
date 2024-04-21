import 'package:firestore_builder_devtools_extension/extensions/num_extensions.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/collections_bloc.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/global_config.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/path_details.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:firestore_builder_devtools_extension/widgets/double_scroll_layout.dart';
import 'package:flutter/material.dart';

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
            child: const _Layout(),
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
    return const _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalConfig(),
          AppDivider.horizontal(),
          PathDetails(),
          AppDivider.horizontal(),
          Expanded(
            child: CollectionsBloc(),
          ),
        ],
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final cardColor = colors.surface;

    return AppPadding.regular(
      child: Card(
        color: cardColor,
        surfaceTintColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: context.theme.dividerColor,
          ),
        ),
        child: child,
      ),
    );
  }
}
