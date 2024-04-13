import 'package:firestore_builder_devtools_extension/theme/app_theme.dart';
import 'package:firestore_builder_devtools_extension/theme/app_theme_data.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  AppThemeData get _appThemeData => AppTheme.of(this);
  SpacingThemeData get spacings => _appThemeData.spacings;
  EdgeInsetsThemeData get edgeInsets => spacings.edgeInsets;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get typos => theme.textTheme;
}
