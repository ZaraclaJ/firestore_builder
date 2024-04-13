import 'package:firestore_builder_devtools_extension/theme/app_theme_data.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum GapSize {
  verySmall,
  small,
  regular,
  semiBig,
  big,
  extraBig;

  double value(SpacingThemeData spacings) {
    return switch (this) {
      GapSize.verySmall => spacings.verySmall,
      GapSize.small => spacings.small,
      GapSize.regular => spacings.regular,
      GapSize.semiBig => spacings.semiBig,
      GapSize.big => spacings.big,
      GapSize.extraBig => spacings.extraBig,
    };
  }
}

class AppGap extends StatelessWidget {
  const AppGap.fromSize({
    required this.size,
    super.key,
  });

  const AppGap.verySmall({
    super.key,
  }) : size = GapSize.verySmall;

  const AppGap.small({
    super.key,
  }) : size = GapSize.small;

  const AppGap.regular({
    super.key,
  }) : size = GapSize.regular;

  const AppGap.semiBig({
    super.key,
  }) : size = GapSize.semiBig;

  const AppGap.big({
    super.key,
  }) : size = GapSize.big;

  const AppGap.extraBig({
    super.key,
  }) : size = GapSize.extraBig;

  final GapSize size;

  @override
  Widget build(BuildContext context) {
    final mainAxisExtent = size.value(context.spacings);
    return Gap(mainAxisExtent);
  }
}
