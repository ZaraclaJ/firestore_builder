// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  @JsonKey(name: Item.nameFieldKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  ItemId get itemId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {@JsonKey(name: Item.nameFieldKey) String name,
      @JsonKey(includeFromJson: false, includeToJson: false) ItemId itemId});

  $ItemIdCopyWith<$Res> get itemId;
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? itemId = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as ItemId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemIdCopyWith<$Res> get itemId {
    return $ItemIdCopyWith<$Res>(_value.itemId, (value) {
      return _then(_value.copyWith(itemId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: Item.nameFieldKey) String name,
      @JsonKey(includeFromJson: false, includeToJson: false) ItemId itemId});

  @override
  $ItemIdCopyWith<$Res> get itemId;
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? itemId = null,
  }) {
    return _then(_$ItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as ItemId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl extends _Item {
  const _$ItemImpl(
      {@JsonKey(name: Item.nameFieldKey) required this.name,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.itemId = const ItemId('')})
      : super._();

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  @JsonKey(name: Item.nameFieldKey)
  final String name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final ItemId itemId;

  @override
  String toString() {
    return 'Item(name: $name, itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, itemId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      __$$ItemImplCopyWithImpl<_$ItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item extends Item {
  const factory _Item(
      {@JsonKey(name: Item.nameFieldKey) required final String name,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final ItemId itemId}) = _$ItemImpl;
  const _Item._() : super._();

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;

  @override
  @JsonKey(name: Item.nameFieldKey)
  String get name;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  ItemId get itemId;
  @override
  @JsonKey(ignore: true)
  _$$ItemImplCopyWith<_$ItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemId _$ItemIdFromJson(Map<String, dynamic> json) {
  return _ItemId.fromJson(json);
}

/// @nodoc
mixin _$ItemId {
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemIdCopyWith<ItemId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemIdCopyWith<$Res> {
  factory $ItemIdCopyWith(ItemId value, $Res Function(ItemId) then) =
      _$ItemIdCopyWithImpl<$Res, ItemId>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$ItemIdCopyWithImpl<$Res, $Val extends ItemId>
    implements $ItemIdCopyWith<$Res> {
  _$ItemIdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemIdImplCopyWith<$Res> implements $ItemIdCopyWith<$Res> {
  factory _$$ItemIdImplCopyWith(
          _$ItemIdImpl value, $Res Function(_$ItemIdImpl) then) =
      __$$ItemIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$ItemIdImplCopyWithImpl<$Res>
    extends _$ItemIdCopyWithImpl<$Res, _$ItemIdImpl>
    implements _$$ItemIdImplCopyWith<$Res> {
  __$$ItemIdImplCopyWithImpl(
      _$ItemIdImpl _value, $Res Function(_$ItemIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$ItemIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemIdImpl implements _ItemId {
  const _$ItemIdImpl(this.value);

  factory _$ItemIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemIdImplFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'ItemId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemIdImplCopyWith<_$ItemIdImpl> get copyWith =>
      __$$ItemIdImplCopyWithImpl<_$ItemIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemIdImplToJson(
      this,
    );
  }
}

abstract class _ItemId implements ItemId {
  const factory _ItemId(final String value) = _$ItemIdImpl;

  factory _ItemId.fromJson(Map<String, dynamic> json) = _$ItemIdImpl.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$ItemIdImplCopyWith<_$ItemIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemPath _$ItemPathFromJson(Map<String, dynamic> json) {
  return _ItemPath.fromJson(json);
}

/// @nodoc
mixin _$ItemPath {
  ItemId get itemId => throw _privateConstructorUsedError;
  TeamId get teamId => throw _privateConstructorUsedError;
  UserId get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemPathCopyWith<ItemPath> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemPathCopyWith<$Res> {
  factory $ItemPathCopyWith(ItemPath value, $Res Function(ItemPath) then) =
      _$ItemPathCopyWithImpl<$Res, ItemPath>;
  @useResult
  $Res call({ItemId itemId, TeamId teamId, UserId userId});

  $ItemIdCopyWith<$Res> get itemId;
  $TeamIdCopyWith<$Res> get teamId;
  $UserIdCopyWith<$Res> get userId;
}

/// @nodoc
class _$ItemPathCopyWithImpl<$Res, $Val extends ItemPath>
    implements $ItemPathCopyWith<$Res> {
  _$ItemPathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? teamId = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as ItemId,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemIdCopyWith<$Res> get itemId {
    return $ItemIdCopyWith<$Res>(_value.itemId, (value) {
      return _then(_value.copyWith(itemId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamIdCopyWith<$Res> get teamId {
    return $TeamIdCopyWith<$Res>(_value.teamId, (value) {
      return _then(_value.copyWith(teamId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserIdCopyWith<$Res> get userId {
    return $UserIdCopyWith<$Res>(_value.userId, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ItemPathImplCopyWith<$Res>
    implements $ItemPathCopyWith<$Res> {
  factory _$$ItemPathImplCopyWith(
          _$ItemPathImpl value, $Res Function(_$ItemPathImpl) then) =
      __$$ItemPathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ItemId itemId, TeamId teamId, UserId userId});

  @override
  $ItemIdCopyWith<$Res> get itemId;
  @override
  $TeamIdCopyWith<$Res> get teamId;
  @override
  $UserIdCopyWith<$Res> get userId;
}

/// @nodoc
class __$$ItemPathImplCopyWithImpl<$Res>
    extends _$ItemPathCopyWithImpl<$Res, _$ItemPathImpl>
    implements _$$ItemPathImplCopyWith<$Res> {
  __$$ItemPathImplCopyWithImpl(
      _$ItemPathImpl _value, $Res Function(_$ItemPathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? teamId = null,
    Object? userId = null,
  }) {
    return _then(_$ItemPathImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as ItemId,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemPathImpl implements _ItemPath {
  const _$ItemPathImpl(
      {required this.itemId, required this.teamId, required this.userId});

  factory _$ItemPathImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemPathImplFromJson(json);

  @override
  final ItemId itemId;
  @override
  final TeamId teamId;
  @override
  final UserId userId;

  @override
  String toString() {
    return 'ItemPath(itemId: $itemId, teamId: $teamId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemPathImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, itemId, teamId, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemPathImplCopyWith<_$ItemPathImpl> get copyWith =>
      __$$ItemPathImplCopyWithImpl<_$ItemPathImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemPathImplToJson(
      this,
    );
  }
}

abstract class _ItemPath implements ItemPath {
  const factory _ItemPath(
      {required final ItemId itemId,
      required final TeamId teamId,
      required final UserId userId}) = _$ItemPathImpl;

  factory _ItemPath.fromJson(Map<String, dynamic> json) =
      _$ItemPathImpl.fromJson;

  @override
  ItemId get itemId;
  @override
  TeamId get teamId;
  @override
  UserId get userId;
  @override
  @JsonKey(ignore: true)
  _$$ItemPathImplCopyWith<_$ItemPathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
