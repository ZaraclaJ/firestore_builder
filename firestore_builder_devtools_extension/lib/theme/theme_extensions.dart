import 'package:firestore_builder_devtools_extension/theme/app_theme.dart';
import 'package:firestore_builder_devtools_extension/theme/app_theme_data.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  AppThemeData get appThemeData => AppTheme.of(this);
  SpacingThemeData get spacings => appThemeData.spacings;
  EdgeInsetsThemeData get edgeInsets => spacings.edgeInsets;
}
