// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Collection {
  String get name => throw _privateConstructorUsedError;
  String get modelName => throw _privateConstructorUsedError;
  List<CollectionField> get fields => throw _privateConstructorUsedError;
  List<Collection> get subCollections => throw _privateConstructorUsedError;
  List<Collection> get collectionPath => throw _privateConstructorUsedError;
  YamlConfig get configLight => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectionCopyWith<Collection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionCopyWith<$Res> {
  factory $CollectionCopyWith(
          Collection value, $Res Function(Collection) then) =
      _$CollectionCopyWithImpl<$Res, Collection>;
  @useResult
  $Res call(
      {String name,
      String modelName,
      List<CollectionField> fields,
      List<Collection> subCollections,
      List<Collection> collectionPath,
      YamlConfig configLight});

  $YamlConfigCopyWith<$Res> get configLight;
}

/// @nodoc
class _$CollectionCopyWithImpl<$Res, $Val extends Collection>
    implements $CollectionCopyWith<$Res> {
  _$CollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? modelName = null,
    Object? fields = null,
    Object? subCollections = null,
    Object? collectionPath = null,
    Object? configLight = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      modelName: null == modelName
          ? _value.modelName
          : modelName // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<CollectionField>,
      subCollections: null == subCollections
          ? _value.subCollections
          : subCollections // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
      collectionPath: null == collectionPath
          ? _value.collectionPath
          : collectionPath // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
      configLight: null == configLight
          ? _value.configLight
          : configLight // ignore: cast_nullable_to_non_nullable
              as YamlConfig,
    ) as $Val);
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
abstract class _$$CollectionImplCopyWith<$Res>
    implements $CollectionCopyWith<$Res> {
  factory _$$CollectionImplCopyWith(
          _$CollectionImpl value, $Res Function(_$CollectionImpl) then) =
      __$$CollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String modelName,
      List<CollectionField> fields,
      List<Collection> subCollections,
      List<Collection> collectionPath,
      YamlConfig configLight});

  @override
  $YamlConfigCopyWith<$Res> get configLight;
}

/// @nodoc
class __$$CollectionImplCopyWithImpl<$Res>
    extends _$CollectionCopyWithImpl<$Res, _$CollectionImpl>
    implements _$$CollectionImplCopyWith<$Res> {
  __$$CollectionImplCopyWithImpl(
      _$CollectionImpl _value, $Res Function(_$CollectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? modelName = null,
    Object? fields = null,
    Object? subCollections = null,
    Object? collectionPath = null,
    Object? configLight = null,
  }) {
    return _then(_$CollectionImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      modelName: null == modelName
          ? _value.modelName
          : modelName // ignore: cast_nullable_to_non_nullable
              as String,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<CollectionField>,
      subCollections: null == subCollections
          ? _value._subCollections
          : subCollections // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
      collectionPath: null == collectionPath
          ? _value._collectionPath
          : collectionPath // ignore: cast_nullable_to_non_nullable
              as List<Collection>,
      configLight: null == configLight
          ? _value.configLight
          : configLight // ignore: cast_nullable_to_non_nullable
              as YamlConfig,
    ));
  }
}

/// @nodoc

class _$CollectionImpl with DiagnosticableTreeMixin implements _Collection {
  const _$CollectionImpl(
      {required this.name,
      required this.modelName,
      required final List<CollectionField> fields,
      required final List<Collection> subCollections,
      required final List<Collection> collectionPath,
      required this.configLight})
      : _fields = fields,
        _subCollections = subCollections,
        _collectionPath = collectionPath;

  @override
  final String name;
  @override
  final String modelName;
  final List<CollectionField> _fields;
  @override
  List<CollectionField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  final List<Collection> _subCollections;
  @override
  List<Collection> get subCollections {
    if (_subCollections is EqualUnmodifiableListView) return _subCollections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subCollections);
  }

  final List<Collection> _collectionPath;
  @override
  List<Collection> get collectionPath {
    if (_collectionPath is EqualUnmodifiableListView) return _collectionPath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_collectionPath);
  }

  @override
  final YamlConfig configLight;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Collection(name: $name, modelName: $modelName, fields: $fields, subCollections: $subCollections, collectionPath: $collectionPath, configLight: $configLight)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Collection'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('modelName', modelName))
      ..add(DiagnosticsProperty('fields', fields))
      ..add(DiagnosticsProperty('subCollections', subCollections))
      ..add(DiagnosticsProperty('collectionPath', collectionPath))
      ..add(DiagnosticsProperty('configLight', configLight));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.modelName, modelName) ||
                other.modelName == modelName) &&
            const DeepCollectionEquality().equals(other._fields, _fields) &&
            const DeepCollectionEquality()
                .equals(other._subCollections, _subCollections) &&
            const DeepCollectionEquality()
                .equals(other._collectionPath, _collectionPath) &&
            (identical(other.configLight, configLight) ||
                other.configLight == configLight));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      modelName,
      const DeepCollectionEquality().hash(_fields),
      const DeepCollectionEquality().hash(_subCollections),
      const DeepCollectionEquality().hash(_collectionPath),
      configLight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionImplCopyWith<_$CollectionImpl> get copyWith =>
      __$$CollectionImplCopyWithImpl<_$CollectionImpl>(this, _$identity);
}

abstract class _Collection implements Collection {
  const factory _Collection(
      {required final String name,
      required final String modelName,
      required final List<CollectionField> fields,
      required final List<Collection> subCollections,
      required final List<Collection> collectionPath,
      required final YamlConfig configLight}) = _$CollectionImpl;

  @override
  String get name;
  @override
  String get modelName;
  @override
  List<CollectionField> get fields;
  @override
  List<Collection> get subCollections;
  @override
  List<Collection> get collectionPath;
  @override
  YamlConfig get configLight;
  @override
  @JsonKey(ignore: true)
  _$$CollectionImplCopyWith<_$CollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
