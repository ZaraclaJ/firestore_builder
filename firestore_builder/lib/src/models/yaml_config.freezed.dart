// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'yaml_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$YamlConfig {
  String get outputPath => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  bool get clear => throw _privateConstructorUsedError;
  List<Collection> get collections => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $YamlConfigCopyWith<YamlConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YamlConfigCopyWith<$Res> {
  factory $YamlConfigCopyWith(
          YamlConfig value, $Res Function(YamlConfig) then) =
      _$YamlConfigCopyWithImpl<$Res, YamlConfig>;
  @useResult
  $Res call(
      {String outputPath,
      String projectName,
      bool clear,
      List<Collection> collections});
}

/// @nodoc
class _$YamlConfigCopyWithImpl<$Res, $Val extends YamlConfig>
    implements $YamlConfigCopyWith<$Res> {
  _$YamlConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outputPath = null,
    Object? projectName = null,
    Object? clear = null,
    Object? collections = null,
  }) {
    return _then(_value.copyWith(
      outputPath: null == outputPath
          ? _value.outputPath
          : outputPath // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      clear: null == clear
          ? _value.clear
          : clear // ignore: cast_nullable_to_non_nullable
              as bool,
      collections: null == collections
          ? _value.collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$YamlConfigImplCopyWith<$Res>
    implements $YamlConfigCopyWith<$Res> {
  factory _$$YamlConfigImplCopyWith(
          _$YamlConfigImpl value, $Res Function(_$YamlConfigImpl) then) =
      __$$YamlConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String outputPath,
      String projectName,
      bool clear,
      List<Collection> collections});
}

/// @nodoc
class __$$YamlConfigImplCopyWithImpl<$Res>
    extends _$YamlConfigCopyWithImpl<$Res, _$YamlConfigImpl>
    implements _$$YamlConfigImplCopyWith<$Res> {
  __$$YamlConfigImplCopyWithImpl(
      _$YamlConfigImpl _value, $Res Function(_$YamlConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? outputPath = null,
    Object? projectName = null,
    Object? clear = null,
    Object? collections = null,
  }) {
    return _then(_$YamlConfigImpl(
      outputPath: null == outputPath
          ? _value.outputPath
          : outputPath // ignore: cast_nullable_to_non_nullable
              as String,
      projectName: null == projectName
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      clear: null == clear
          ? _value.clear
          : clear // ignore: cast_nullable_to_non_nullable
              as bool,
      collections: null == collections
          ? _value._collections
          : collections // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
    ));
  }
}

/// @nodoc

class _$YamlConfigImpl extends _YamlConfig with DiagnosticableTreeMixin {
  const _$YamlConfigImpl(
      {required this.outputPath,
      required this.projectName,
      required this.clear,
      required final List<Collection> collections})
      : _collections = collections,
        super._();

  @override
  final String outputPath;
  @override
  final String projectName;
  @override
  final bool clear;
  final List<Collection> _collections;
  @override
  List<Collection> get collections {
    if (_collections is EqualUnmodifiableListView) return _collections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collections);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YamlConfig(outputPath: $outputPath, projectName: $projectName, clear: $clear, collections: $collections)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'YamlConfig'))
      ..add(DiagnosticsProperty('outputPath', outputPath))
      ..add(DiagnosticsProperty('projectName', projectName))
      ..add(DiagnosticsProperty('clear', clear))
      ..add(DiagnosticsProperty('collections', collections));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YamlConfigImpl &&
            (identical(other.outputPath, outputPath) ||
                other.outputPath == outputPath) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.clear, clear) || other.clear == clear) &&
            const DeepCollectionEquality()
                .equals(other._collections, _collections));
  }

  @override
  int get hashCode => Object.hash(runtimeType, outputPath, projectName, clear,
      const DeepCollectionEquality().hash(_collections));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$YamlConfigImplCopyWith<_$YamlConfigImpl> get copyWith =>
      __$$YamlConfigImplCopyWithImpl<_$YamlConfigImpl>(this, _$identity);
}

abstract class _YamlConfig extends YamlConfig {
  const factory _YamlConfig(
      {required final String outputPath,
      required final String projectName,
      required final bool clear,
      required final List<Collection> collections}) = _$YamlConfigImpl;
  const _YamlConfig._() : super._();

  @override
  String get outputPath;
  @override
  String get projectName;
  @override
  bool get clear;
  @override
  List<Collection> get collections;
  @override
  @JsonKey(ignore: true)
  _$$YamlConfigImplCopyWith<_$YamlConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
