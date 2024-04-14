import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_theme_data.freezed.dart';

@freezed
class AppThemeData with _$AppThemeData {
  const factory AppThemeData({
    required SpacingThemeData spacings,
    required RadiusThemeData radiuses,
  }) = _AppThemeData;

  factory AppThemeData.regular() => AppThemeData(
        spacings: SpacingThemeData.regular(),
        radiuses: RadiusThemeData.regular(),
      );
}

@freezed
class SpacingThemeData with _$SpacingThemeData {
  const factory SpacingThemeData({
    required double verySmall,
    required double small,
    required double regular,
    required double semiBig,
    required double big,
    required double extraBig,
  }) = _SpacingThemeData;

  const SpacingThemeData._();

  factory SpacingThemeData.regular() => const SpacingThemeData(
        verySmall: 2,
        small: 4,
        regular: 8,
        semiBig: 16,
        big: 24,
        extraBig: 32,
      );

  EdgeInsetsThemeData get edgeInsets => EdgeInsetsThemeData(this);
}

class EdgeInsetsThemeData {
  const EdgeInsetsThemeData(this._spacing);

  EdgeInsets get verySmall => EdgeInsets.all(_spacing.verySmall);
  EdgeInsets get small => EdgeInsets.all(_spacing.small);
  EdgeInsets get regular => EdgeInsets.all(_spacing.regular);
  EdgeInsets get semiBig => EdgeInsets.all(_spacing.semiBig);
  EdgeInsets get big => EdgeInsets.all(_spacing.big);
  EdgeInsets get extraBig => EdgeInsets.all(_spacing.extraBig);

  final SpacingThemeData _spacing;
}

@freezed
class RadiusThemeData with _$RadiusThemeData {
  const factory RadiusThemeData({
    required double small,
    required double regular,
    required double big,
    required double extraBig,
  }) = _RadiusThemeData;

  const RadiusThemeData._();

  factory RadiusThemeData.regular() => const RadiusThemeData(
        small: 2,
        regular: 8,
        big: 16,
        extraBig: 24,
      );

  BorderRadiusThemeData get borderRadius => BorderRadiusThemeData(this);
}

class BorderRadiusThemeData {
  const BorderRadiusThemeData(this._radius);
  final RadiusThemeData _radius;

  BorderRadius get small => BorderRadius.all(Radius.circular(_radius.small));
  BorderRadius get regular => BorderRadius.all(Radius.circular(_radius.regular));
  BorderRadius get big => BorderRadius.all(Radius.circular(_radius.big));
  BorderRadius get extraBig => BorderRadius.all(Radius.circular(_radius.extraBig));
}
