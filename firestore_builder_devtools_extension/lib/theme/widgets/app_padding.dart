import 'package:firestore_builder_devtools_extension/theme/app_theme_data.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

enum PaddingSize {
  verySmall,
  small,
  regular,
  semiBig,
  big,
  extraBig;

  EdgeInsets value(EdgeInsetsThemeData edgeInsets) {
    return switch (this) {
      PaddingSize.verySmall => edgeInsets.verySmall,
      PaddingSize.small => edgeInsets.small,
      PaddingSize.regular => edgeInsets.regular,
      PaddingSize.semiBig => edgeInsets.semiBig,
      PaddingSize.big => edgeInsets.big,
      PaddingSize.extraBig => edgeInsets.extraBig,
    };
  }
}

class AppPadding extends StatelessWidget {
  const AppPadding.verySmall({
    required this.child,
    super.key,
  }) : _size = PaddingSize.verySmall;

  const AppPadding.small({
    required this.child,
    super.key,
  }) : _size = PaddingSize.small;

  const AppPadding.regular({
    required this.child,
    super.key,
  }) : _size = PaddingSize.regular;

  const AppPadding.semiBig({
    required this.child,
    super.key,
  }) : _size = PaddingSize.semiBig;

  const AppPadding.big({
    required this.child,
    super.key,
  }) : _size = PaddingSize.big;

  const AppPadding.extraBig({
    required this.child,
    super.key,
  }) : _size = PaddingSize.extraBig;

  final Widget child;
  final PaddingSize _size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _size.value(context.edgeInsets),
      child: child,
    );
  }
}
