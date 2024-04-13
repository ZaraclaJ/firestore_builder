import 'package:firestore_builder_devtools_extension/theme/app_theme_data.dart';
import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({
    required super.child,
    required this.data,
    super.key,
  });

  final AppThemeData data;

  static AppThemeData of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return widget!.data;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}
