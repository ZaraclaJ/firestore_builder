// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppThemeData {
  SpacingThemeData get spacings => throw _privateConstructorUsedError;
  RadiusThemeData get radiuses => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppThemeDataCopyWith<AppThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppThemeDataCopyWith<$Res> {
  factory $AppThemeDataCopyWith(
          AppThemeData value, $Res Function(AppThemeData) then) =
      _$AppThemeDataCopyWithImpl<$Res, AppThemeData>;
  @useResult
  $Res call({SpacingThemeData spacings, RadiusThemeData radiuses});

  $SpacingThemeDataCopyWith<$Res> get spacings;
  $RadiusThemeDataCopyWith<$Res> get radiuses;
}

/// @nodoc
class _$AppThemeDataCopyWithImpl<$Res, $Val extends AppThemeData>
    implements $AppThemeDataCopyWith<$Res> {
  _$AppThemeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spacings = null,
    Object? radiuses = null,
  }) {
    return _then(_value.copyWith(
      spacings: null == spacings
          ? _value.spacings
          : spacings // ignore: cast_nullable_to_non_nullable
              as SpacingThemeData,
      radiuses: null == radiuses
          ? _value.radiuses
          : radiuses // ignore: cast_nullable_to_non_nullable
              as RadiusThemeData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpacingThemeDataCopyWith<$Res> get spacings {
    return $SpacingThemeDataCopyWith<$Res>(_value.spacings, (value) {
      return _then(_value.copyWith(spacings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RadiusThemeDataCopyWith<$Res> get radiuses {
    return $RadiusThemeDataCopyWith<$Res>(_value.radiuses, (value) {
      return _then(_value.copyWith(radiuses: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppThemeDataImplCopyWith<$Res>
    implements $AppThemeDataCopyWith<$Res> {
  factory _$$AppThemeDataImplCopyWith(
          _$AppThemeDataImpl value, $Res Function(_$AppThemeDataImpl) then) =
      __$$AppThemeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SpacingThemeData spacings, RadiusThemeData radiuses});

  @override
  $SpacingThemeDataCopyWith<$Res> get spacings;
  @override
  $RadiusThemeDataCopyWith<$Res> get radiuses;
}

/// @nodoc
class __$$AppThemeDataImplCopyWithImpl<$Res>
    extends _$AppThemeDataCopyWithImpl<$Res, _$AppThemeDataImpl>
    implements _$$AppThemeDataImplCopyWith<$Res> {
  __$$AppThemeDataImplCopyWithImpl(
      _$AppThemeDataImpl _value, $Res Function(_$AppThemeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spacings = null,
    Object? radiuses = null,
  }) {
    return _then(_$AppThemeDataImpl(
      spacings: null == spacings
          ? _value.spacings
          : spacings // ignore: cast_nullable_to_non_nullable
              as SpacingThemeData,
      radiuses: null == radiuses
          ? _value.radiuses
          : radiuses // ignore: cast_nullable_to_non_nullable
              as RadiusThemeData,
    ));
  }
}

/// @nodoc

class _$AppThemeDataImpl implements _AppThemeData {
  const _$AppThemeDataImpl({required this.spacings, required this.radiuses});

  @override
  final SpacingThemeData spacings;
  @override
  final RadiusThemeData radiuses;

  @override
  String toString() {
    return 'AppThemeData(spacings: $spacings, radiuses: $radiuses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeDataImpl &&
            (identical(other.spacings, spacings) ||
                other.spacings == spacings) &&
            (identical(other.radiuses, radiuses) ||
                other.radiuses == radiuses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spacings, radiuses);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppThemeDataImplCopyWith<_$AppThemeDataImpl> get copyWith =>
      __$$AppThemeDataImplCopyWithImpl<_$AppThemeDataImpl>(this, _$identity);
}

abstract class _AppThemeData implements AppThemeData {
  const factory _AppThemeData(
      {required final SpacingThemeData spacings,
      required final RadiusThemeData radiuses}) = _$AppThemeDataImpl;

  @override
  SpacingThemeData get spacings;
  @override
  RadiusThemeData get radiuses;
  @override
  @JsonKey(ignore: true)
  _$$AppThemeDataImplCopyWith<_$AppThemeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SpacingThemeData {
  double get verySmall => throw _privateConstructorUsedError;
  double get small => throw _privateConstructorUsedError;
  double get regular => throw _privateConstructorUsedError;
  double get semiBig => throw _privateConstructorUsedError;
  double get big => throw _privateConstructorUsedError;
  double get extraBig => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpacingThemeDataCopyWith<SpacingThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpacingThemeDataCopyWith<$Res> {
  factory $SpacingThemeDataCopyWith(
          SpacingThemeData value, $Res Function(SpacingThemeData) then) =
      _$SpacingThemeDataCopyWithImpl<$Res, SpacingThemeData>;
  @useResult
  $Res call(
      {double verySmall,
      double small,
      double regular,
      double semiBig,
      double big,
      double extraBig});
}

/// @nodoc
class _$SpacingThemeDataCopyWithImpl<$Res, $Val extends SpacingThemeData>
    implements $SpacingThemeDataCopyWith<$Res> {
  _$SpacingThemeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verySmall = null,
    Object? small = null,
    Object? regular = null,
    Object? semiBig = null,
    Object? big = null,
    Object? extraBig = null,
  }) {
    return _then(_value.copyWith(
      verySmall: null == verySmall
          ? _value.verySmall
          : verySmall // ignore: cast_nullable_to_non_nullable
              as double,
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as double,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as double,
      semiBig: null == semiBig
          ? _value.semiBig
          : semiBig // ignore: cast_nullable_to_non_nullable
              as double,
      big: null == big
          ? _value.big
          : big // ignore: cast_nullable_to_non_nullable
              as double,
      extraBig: null == extraBig
          ? _value.extraBig
          : extraBig // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpacingThemeDataImplCopyWith<$Res>
    implements $SpacingThemeDataCopyWith<$Res> {
  factory _$$SpacingThemeDataImplCopyWith(_$SpacingThemeDataImpl value,
          $Res Function(_$SpacingThemeDataImpl) then) =
      __$$SpacingThemeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double verySmall,
      double small,
      double regular,
      double semiBig,
      double big,
      double extraBig});
}

/// @nodoc
class __$$SpacingThemeDataImplCopyWithImpl<$Res>
    extends _$SpacingThemeDataCopyWithImpl<$Res, _$SpacingThemeDataImpl>
    implements _$$SpacingThemeDataImplCopyWith<$Res> {
  __$$SpacingThemeDataImplCopyWithImpl(_$SpacingThemeDataImpl _value,
      $Res Function(_$SpacingThemeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verySmall = null,
    Object? small = null,
    Object? regular = null,
    Object? semiBig = null,
    Object? big = null,
    Object? extraBig = null,
  }) {
    return _then(_$SpacingThemeDataImpl(
      verySmall: null == verySmall
          ? _value.verySmall
          : verySmall // ignore: cast_nullable_to_non_nullable
              as double,
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as double,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as double,
      semiBig: null == semiBig
          ? _value.semiBig
          : semiBig // ignore: cast_nullable_to_non_nullable
              as double,
      big: null == big
          ? _value.big
          : big // ignore: cast_nullable_to_non_nullable
              as double,
      extraBig: null == extraBig
          ? _value.extraBig
          : extraBig // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SpacingThemeDataImpl extends _SpacingThemeData {
  const _$SpacingThemeDataImpl(
      {required this.verySmall,
      required this.small,
      required this.regular,
      required this.semiBig,
      required this.big,
      required this.extraBig})
      : super._();

  @override
  final double verySmall;
  @override
  final double small;
  @override
  final double regular;
  @override
  final double semiBig;
  @override
  final double big;
  @override
  final double extraBig;

  @override
  String toString() {
    return 'SpacingThemeData(verySmall: $verySmall, small: $small, regular: $regular, semiBig: $semiBig, big: $big, extraBig: $extraBig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpacingThemeDataImpl &&
            (identical(other.verySmall, verySmall) ||
                other.verySmall == verySmall) &&
            (identical(other.small, small) || other.small == small) &&
            (identical(other.regular, regular) || other.regular == regular) &&
            (identical(other.semiBig, semiBig) || other.semiBig == semiBig) &&
            (identical(other.big, big) || other.big == big) &&
            (identical(other.extraBig, extraBig) ||
                other.extraBig == extraBig));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, verySmall, small, regular, semiBig, big, extraBig);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpacingThemeDataImplCopyWith<_$SpacingThemeDataImpl> get copyWith =>
      __$$SpacingThemeDataImplCopyWithImpl<_$SpacingThemeDataImpl>(
          this, _$identity);
}

abstract class _SpacingThemeData extends SpacingThemeData {
  const factory _SpacingThemeData(
      {required final double verySmall,
      required final double small,
      required final double regular,
      required final double semiBig,
      required final double big,
      required final double extraBig}) = _$SpacingThemeDataImpl;
  const _SpacingThemeData._() : super._();

  @override
  double get verySmall;
  @override
  double get small;
  @override
  double get regular;
  @override
  double get semiBig;
  @override
  double get big;
  @override
  double get extraBig;
  @override
  @JsonKey(ignore: true)
  _$$SpacingThemeDataImplCopyWith<_$SpacingThemeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RadiusThemeData {
  double get small => throw _privateConstructorUsedError;
  double get regular => throw _privateConstructorUsedError;
  double get big => throw _privateConstructorUsedError;
  double get extraBig => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RadiusThemeDataCopyWith<RadiusThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadiusThemeDataCopyWith<$Res> {
  factory $RadiusThemeDataCopyWith(
          RadiusThemeData value, $Res Function(RadiusThemeData) then) =
      _$RadiusThemeDataCopyWithImpl<$Res, RadiusThemeData>;
  @useResult
  $Res call({double small, double regular, double big, double extraBig});
}

/// @nodoc
class _$RadiusThemeDataCopyWithImpl<$Res, $Val extends RadiusThemeData>
    implements $RadiusThemeDataCopyWith<$Res> {
  _$RadiusThemeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? small = null,
    Object? regular = null,
    Object? big = null,
    Object? extraBig = null,
  }) {
    return _then(_value.copyWith(
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as double,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as double,
      big: null == big
          ? _value.big
          : big // ignore: cast_nullable_to_non_nullable
              as double,
      extraBig: null == extraBig
          ? _value.extraBig
          : extraBig // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RadiusThemeDataImplCopyWith<$Res>
    implements $RadiusThemeDataCopyWith<$Res> {
  factory _$$RadiusThemeDataImplCopyWith(_$RadiusThemeDataImpl value,
          $Res Function(_$RadiusThemeDataImpl) then) =
      __$$RadiusThemeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double small, double regular, double big, double extraBig});
}

/// @nodoc
class __$$RadiusThemeDataImplCopyWithImpl<$Res>
    extends _$RadiusThemeDataCopyWithImpl<$Res, _$RadiusThemeDataImpl>
    implements _$$RadiusThemeDataImplCopyWith<$Res> {
  __$$RadiusThemeDataImplCopyWithImpl(
      _$RadiusThemeDataImpl _value, $Res Function(_$RadiusThemeDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? small = null,
    Object? regular = null,
    Object? big = null,
    Object? extraBig = null,
  }) {
    return _then(_$RadiusThemeDataImpl(
      small: null == small
          ? _value.small
          : small // ignore: cast_nullable_to_non_nullable
              as double,
      regular: null == regular
          ? _value.regular
          : regular // ignore: cast_nullable_to_non_nullable
              as double,
      big: null == big
          ? _value.big
          : big // ignore: cast_nullable_to_non_nullable
              as double,
      extraBig: null == extraBig
          ? _value.extraBig
          : extraBig // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$RadiusThemeDataImpl extends _RadiusThemeData {
  const _$RadiusThemeDataImpl(
      {required this.small,
      required this.regular,
      required this.big,
      required this.extraBig})
      : super._();

  @override
  final double small;
  @override
  final double regular;
  @override
  final double big;
  @override
  final double extraBig;

  @override
  String toString() {
    return 'RadiusThemeData(small: $small, regular: $regular, big: $big, extraBig: $extraBig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadiusThemeDataImpl &&
            (identical(other.small, small) || other.small == small) &&
            (identical(other.regular, regular) || other.regular == regular) &&
            (identical(other.big, big) || other.big == big) &&
            (identical(other.extraBig, extraBig) ||
                other.extraBig == extraBig));
  }

  @override
  int get hashCode => Object.hash(runtimeType, small, regular, big, extraBig);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RadiusThemeDataImplCopyWith<_$RadiusThemeDataImpl> get copyWith =>
      __$$RadiusThemeDataImplCopyWithImpl<_$RadiusThemeDataImpl>(
          this, _$identity);
}

abstract class _RadiusThemeData extends RadiusThemeData {
  const factory _RadiusThemeData(
      {required final double small,
      required final double regular,
      required final double big,
      required final double extraBig}) = _$RadiusThemeDataImpl;
  const _RadiusThemeData._() : super._();

  @override
  double get small;
  @override
  double get regular;
  @override
  double get big;
  @override
  double get extraBig;
  @override
  @JsonKey(ignore: true)
  _$$RadiusThemeDataImplCopyWith<_$RadiusThemeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
