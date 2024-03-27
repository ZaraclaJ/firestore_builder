// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'updated_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdatedValueTeamSize _$UpdatedValueTeamSizeFromJson(Map<String, dynamic> json) {
  return _UpdatedValueTeamSize.fromJson(json);
}

/// @nodoc
mixin _$UpdatedValueTeamSize {
  TeamSize get teamSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdatedValueTeamSizeCopyWith<UpdatedValueTeamSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatedValueTeamSizeCopyWith<$Res> {
  factory $UpdatedValueTeamSizeCopyWith(UpdatedValueTeamSize value,
          $Res Function(UpdatedValueTeamSize) then) =
      _$UpdatedValueTeamSizeCopyWithImpl<$Res, UpdatedValueTeamSize>;
  @useResult
  $Res call({TeamSize teamSize});
}

/// @nodoc
class _$UpdatedValueTeamSizeCopyWithImpl<$Res,
        $Val extends UpdatedValueTeamSize>
    implements $UpdatedValueTeamSizeCopyWith<$Res> {
  _$UpdatedValueTeamSizeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamSize = null,
  }) {
    return _then(_value.copyWith(
      teamSize: null == teamSize
          ? _value.teamSize
          : teamSize // ignore: cast_nullable_to_non_nullable
              as TeamSize,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatedValueTeamSizeImplCopyWith<$Res>
    implements $UpdatedValueTeamSizeCopyWith<$Res> {
  factory _$$UpdatedValueTeamSizeImplCopyWith(_$UpdatedValueTeamSizeImpl value,
          $Res Function(_$UpdatedValueTeamSizeImpl) then) =
      __$$UpdatedValueTeamSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TeamSize teamSize});
}

/// @nodoc
class __$$UpdatedValueTeamSizeImplCopyWithImpl<$Res>
    extends _$UpdatedValueTeamSizeCopyWithImpl<$Res, _$UpdatedValueTeamSizeImpl>
    implements _$$UpdatedValueTeamSizeImplCopyWith<$Res> {
  __$$UpdatedValueTeamSizeImplCopyWithImpl(_$UpdatedValueTeamSizeImpl _value,
      $Res Function(_$UpdatedValueTeamSizeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamSize = null,
  }) {
    return _then(_$UpdatedValueTeamSizeImpl(
      null == teamSize
          ? _value.teamSize
          : teamSize // ignore: cast_nullable_to_non_nullable
              as TeamSize,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatedValueTeamSizeImpl extends _UpdatedValueTeamSize {
  const _$UpdatedValueTeamSizeImpl(this.teamSize) : super._();

  factory _$UpdatedValueTeamSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatedValueTeamSizeImplFromJson(json);

  @override
  final TeamSize teamSize;

  @override
  String toString() {
    return 'UpdatedValueTeamSize(teamSize: $teamSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatedValueTeamSizeImpl &&
            (identical(other.teamSize, teamSize) ||
                other.teamSize == teamSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, teamSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatedValueTeamSizeImplCopyWith<_$UpdatedValueTeamSizeImpl>
      get copyWith =>
          __$$UpdatedValueTeamSizeImplCopyWithImpl<_$UpdatedValueTeamSizeImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatedValueTeamSizeImplToJson(
      this,
    );
  }
}

abstract class _UpdatedValueTeamSize extends UpdatedValueTeamSize {
  const factory _UpdatedValueTeamSize(final TeamSize teamSize) =
      _$UpdatedValueTeamSizeImpl;
  const _UpdatedValueTeamSize._() : super._();

  factory _UpdatedValueTeamSize.fromJson(Map<String, dynamic> json) =
      _$UpdatedValueTeamSizeImpl.fromJson;

  @override
  TeamSize get teamSize;
  @override
  @JsonKey(ignore: true)
  _$$UpdatedValueTeamSizeImplCopyWith<_$UpdatedValueTeamSizeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
