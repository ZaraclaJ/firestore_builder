// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CollectionField {
  String get name => throw _privateConstructorUsedError;
  FieldType get type => throw _privateConstructorUsedError;
  bool get acceptFieldValue => throw _privateConstructorUsedError;
  YamlConfig get configLight => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectionFieldCopyWith<CollectionField> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionFieldCopyWith<$Res> {
  factory $CollectionFieldCopyWith(
          CollectionField value, $Res Function(CollectionField) then) =
      _$CollectionFieldCopyWithImpl<$Res, CollectionField>;
  @useResult
  $Res call(
      {String name,
      FieldType type,
      bool acceptFieldValue,
      YamlConfig configLight});

  $FieldTypeCopyWith<$Res> get type;
  $YamlConfigCopyWith<$Res> get configLight;
}

/// @nodoc
class _$CollectionFieldCopyWithImpl<$Res, $Val extends CollectionField>
    implements $CollectionFieldCopyWith<$Res> {
  _$CollectionFieldCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? acceptFieldValue = null,
    Object? configLight = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FieldType,
      acceptFieldValue: null == acceptFieldValue
          ? _value.acceptFieldValue
          : acceptFieldValue // ignore: cast_nullable_to_non_nullable
              as bool,
      configLight: null == configLight
          ? _value.configLight
          : configLight // ignore: cast_nullable_to_non_nullable
              as YamlConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FieldTypeCopyWith<$Res> get type {
    return $FieldTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $YamlConfigCopyWith<$Res> get configLight {
    return $YamlConfigCopyWith<$Res>(_value.configLight, (value) {
      return _then(_value.copyWith(configLight: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CollectionFieldImplCopyWith<$Res>
    implements $CollectionFieldCopyWith<$Res> {
  factory _$$CollectionFieldImplCopyWith(_$CollectionFieldImpl value,
          $Res Function(_$CollectionFieldImpl) then) =
      __$$CollectionFieldImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      FieldType type,
      bool acceptFieldValue,
      YamlConfig configLight});

  @override
  $FieldTypeCopyWith<$Res> get type;
  @override
  $YamlConfigCopyWith<$Res> get configLight;
}

/// @nodoc
class __$$CollectionFieldImplCopyWithImpl<$Res>
    extends _$CollectionFieldCopyWithImpl<$Res, _$CollectionFieldImpl>
    implements _$$CollectionFieldImplCopyWith<$Res> {
  __$$CollectionFieldImplCopyWithImpl(
      _$CollectionFieldImpl _value, $Res Function(_$CollectionFieldImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? acceptFieldValue = null,
    Object? configLight = null,
  }) {
    return _then(_$CollectionFieldImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FieldType,
      acceptFieldValue: null == acceptFieldValue
          ? _value.acceptFieldValue
          : acceptFieldValue // ignore: cast_nullable_to_non_nullable
              as bool,
      configLight: null == configLight
          ? _value.configLight
          : configLight // ignore: cast_nullable_to_non_nullable
              as YamlConfig,
    ));
  }
}

/// @nodoc

class _$CollectionFieldImpl extends _CollectionField
    with DiagnosticableTreeMixin {
  const _$CollectionFieldImpl(
      {required this.name,
      required this.type,
      required this.acceptFieldValue,
      required this.configLight})
      : super._();

  @override
  final String name;
  @override
  final FieldType type;
  @override
  final bool acceptFieldValue;
  @override
  final YamlConfig configLight;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CollectionField(name: $name, type: $type, acceptFieldValue: $acceptFieldValue, configLight: $configLight)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CollectionField'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('acceptFieldValue', acceptFieldValue))
      ..add(DiagnosticsProperty('configLight', configLight));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionFieldImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.acceptFieldValue, acceptFieldValue) ||
                other.acceptFieldValue == acceptFieldValue) &&
            (identical(other.configLight, configLight) ||
                other.configLight == configLight));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, type, acceptFieldValue, configLight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionFieldImplCopyWith<_$CollectionFieldImpl> get copyWith =>
      __$$CollectionFieldImplCopyWithImpl<_$CollectionFieldImpl>(
          this, _$identity);
}

abstract class _CollectionField extends CollectionField {
  const factory _CollectionField(
      {required final String name,
      required final FieldType type,
      required final bool acceptFieldValue,
      required final YamlConfig configLight}) = _$CollectionFieldImpl;
  const _CollectionField._() : super._();

  @override
  String get name;
  @override
  FieldType get type;
  @override
  bool get acceptFieldValue;
  @override
  YamlConfig get configLight;
  @override
  @JsonKey(ignore: true)
  _$$CollectionFieldImplCopyWith<_$CollectionFieldImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
