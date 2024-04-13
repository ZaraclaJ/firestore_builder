import 'package:firestore_builder_devtools_extension/theme/app_theme.dart';
import 'package:firestore_builder_devtools_extension/theme/app_theme_data.dart';
import 'package:flutter/material.dart';

class ResponsiveTheme extends StatelessWidget {
  const ResponsiveTheme({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appThemeData = AppThemeData.regular();
    return AppTheme(
      data: appThemeData,
      child: child,
    );
  }
}
