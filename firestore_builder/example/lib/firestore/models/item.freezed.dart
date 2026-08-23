// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Item {

@JsonKey(name: Item.nameFieldKey) String get name;@JsonKey(includeFromJson: false, includeToJson: false) ItemId get itemId;
/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemCopyWith<Item> get copyWith => _$ItemCopyWithImpl<Item>(this as Item, _$identity);

  /// Serializes this Item to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Item&&(identical(other.name, name) || other.name == name)&&(identical(other.itemId, itemId) || other.itemId == itemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,itemId);

@override
String toString() {
  return 'Item(name: $name, itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class $ItemCopyWith<$Res>  {
  factory $ItemCopyWith(Item value, $Res Function(Item) _then) = _$ItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: Item.nameFieldKey) String name,@JsonKey(includeFromJson: false, includeToJson: false) ItemId itemId
});


$ItemIdCopyWith<$Res> get itemId;

}
/// @nodoc
class _$ItemCopyWithImpl<$Res>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._self, this._then);

  final Item _self;
  final $Res Function(Item) _then;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? itemId = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as ItemId,
  ));
}
/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemIdCopyWith<$Res> get itemId {
  
  return $ItemIdCopyWith<$Res>(_self.itemId, (value) {
    return _then(_self.copyWith(itemId: value));
  });
}
}


/// Adds pattern-matching-related methods to [Item].
extension ItemPatterns on Item {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Item value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Item() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Item value)  $default,){
final _that = this;
switch (_that) {
case _Item():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Item value)?  $default,){
final _that = this;
switch (_that) {
case _Item() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: Item.nameFieldKey)  String name, @JsonKey(includeFromJson: false, includeToJson: false)  ItemId itemId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Item() when $default != null:
return $default(_that.name,_that.itemId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: Item.nameFieldKey)  String name, @JsonKey(includeFromJson: false, includeToJson: false)  ItemId itemId)  $default,) {final _that = this;
switch (_that) {
case _Item():
return $default(_that.name,_that.itemId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: Item.nameFieldKey)  String name, @JsonKey(includeFromJson: false, includeToJson: false)  ItemId itemId)?  $default,) {final _that = this;
switch (_that) {
case _Item() when $default != null:
return $default(_that.name,_that.itemId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Item extends Item {
  const _Item({@JsonKey(name: Item.nameFieldKey) required this.name, @JsonKey(includeFromJson: false, includeToJson: false) this.itemId = const ItemId('')}): super._();
  factory _Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

@override@JsonKey(name: Item.nameFieldKey) final  String name;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  ItemId itemId;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemCopyWith<_Item> get copyWith => __$ItemCopyWithImpl<_Item>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Item&&(identical(other.name, name) || other.name == name)&&(identical(other.itemId, itemId) || other.itemId == itemId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,itemId);

@override
String toString() {
  return 'Item(name: $name, itemId: $itemId)';
}


}

/// @nodoc
abstract mixin class _$ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$ItemCopyWith(_Item value, $Res Function(_Item) _then) = __$ItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: Item.nameFieldKey) String name,@JsonKey(includeFromJson: false, includeToJson: false) ItemId itemId
});


@override $ItemIdCopyWith<$Res> get itemId;

}
/// @nodoc
class __$ItemCopyWithImpl<$Res>
    implements _$ItemCopyWith<$Res> {
  __$ItemCopyWithImpl(this._self, this._then);

  final _Item _self;
  final $Res Function(_Item) _then;

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? itemId = null,}) {
  return _then(_Item(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as ItemId,
  ));
}

/// Create a copy of Item
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemIdCopyWith<$Res> get itemId {
  
  return $ItemIdCopyWith<$Res>(_self.itemId, (value) {
    return _then(_self.copyWith(itemId: value));
  });
}
}


/// @nodoc
mixin _$ItemId {

 String get value;
/// Create a copy of ItemId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemIdCopyWith<ItemId> get copyWith => _$ItemIdCopyWithImpl<ItemId>(this as ItemId, _$identity);

  /// Serializes this ItemId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ItemId(value: $value)';
}


}

/// @nodoc
abstract mixin class $ItemIdCopyWith<$Res>  {
  factory $ItemIdCopyWith(ItemId value, $Res Function(ItemId) _then) = _$ItemIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$ItemIdCopyWithImpl<$Res>
    implements $ItemIdCopyWith<$Res> {
  _$ItemIdCopyWithImpl(this._self, this._then);

  final ItemId _self;
  final $Res Function(ItemId) _then;

/// Create a copy of ItemId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemId].
extension ItemIdPatterns on ItemId {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemId() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemId value)  $default,){
final _that = this;
switch (_that) {
case _ItemId():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemId value)?  $default,){
final _that = this;
switch (_that) {
case _ItemId() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemId() when $default != null:
return $default(_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value)  $default,) {final _that = this;
switch (_that) {
case _ItemId():
return $default(_that.value);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value)?  $default,) {final _that = this;
switch (_that) {
case _ItemId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemId implements ItemId {
  const _ItemId(this.value);
  factory _ItemId.fromJson(Map<String, dynamic> json) => _$ItemIdFromJson(json);

@override final  String value;

/// Create a copy of ItemId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemIdCopyWith<_ItemId> get copyWith => __$ItemIdCopyWithImpl<_ItemId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'ItemId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$ItemIdCopyWith<$Res> implements $ItemIdCopyWith<$Res> {
  factory _$ItemIdCopyWith(_ItemId value, $Res Function(_ItemId) _then) = __$ItemIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$ItemIdCopyWithImpl<$Res>
    implements _$ItemIdCopyWith<$Res> {
  __$ItemIdCopyWithImpl(this._self, this._then);

  final _ItemId _self;
  final $Res Function(_ItemId) _then;

/// Create a copy of ItemId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_ItemId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ItemPath {

 ItemId get itemId; TeamId get teamId; UserId get userId;
/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemPathCopyWith<ItemPath> get copyWith => _$ItemPathCopyWithImpl<ItemPath>(this as ItemPath, _$identity);

  /// Serializes this ItemPath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemPath&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,teamId,userId);

@override
String toString() {
  return 'ItemPath(itemId: $itemId, teamId: $teamId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ItemPathCopyWith<$Res>  {
  factory $ItemPathCopyWith(ItemPath value, $Res Function(ItemPath) _then) = _$ItemPathCopyWithImpl;
@useResult
$Res call({
 ItemId itemId, TeamId teamId, UserId userId
});


$ItemIdCopyWith<$Res> get itemId;$TeamIdCopyWith<$Res> get teamId;$UserIdCopyWith<$Res> get userId;

}
/// @nodoc
class _$ItemPathCopyWithImpl<$Res>
    implements $ItemPathCopyWith<$Res> {
  _$ItemPathCopyWithImpl(this._self, this._then);

  final ItemPath _self;
  final $Res Function(ItemPath) _then;

/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? teamId = null,Object? userId = null,}) {
  return _then(_self.copyWith(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as ItemId,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,
  ));
}
/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemIdCopyWith<$Res> get itemId {
  
  return $ItemIdCopyWith<$Res>(_self.itemId, (value) {
    return _then(_self.copyWith(itemId: value));
  });
}/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}
}


/// Adds pattern-matching-related methods to [ItemPath].
extension ItemPathPatterns on ItemPath {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemPath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemPath() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemPath value)  $default,){
final _that = this;
switch (_that) {
case _ItemPath():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemPath value)?  $default,){
final _that = this;
switch (_that) {
case _ItemPath() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ItemId itemId,  TeamId teamId,  UserId userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemPath() when $default != null:
return $default(_that.itemId,_that.teamId,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ItemId itemId,  TeamId teamId,  UserId userId)  $default,) {final _that = this;
switch (_that) {
case _ItemPath():
return $default(_that.itemId,_that.teamId,_that.userId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ItemId itemId,  TeamId teamId,  UserId userId)?  $default,) {final _that = this;
switch (_that) {
case _ItemPath() when $default != null:
return $default(_that.itemId,_that.teamId,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemPath implements ItemPath {
  const _ItemPath({required this.itemId, required this.teamId, required this.userId});
  factory _ItemPath.fromJson(Map<String, dynamic> json) => _$ItemPathFromJson(json);

@override final  ItemId itemId;
@override final  TeamId teamId;
@override final  UserId userId;

/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemPathCopyWith<_ItemPath> get copyWith => __$ItemPathCopyWithImpl<_ItemPath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemPathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemPath&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,itemId,teamId,userId);

@override
String toString() {
  return 'ItemPath(itemId: $itemId, teamId: $teamId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$ItemPathCopyWith<$Res> implements $ItemPathCopyWith<$Res> {
  factory _$ItemPathCopyWith(_ItemPath value, $Res Function(_ItemPath) _then) = __$ItemPathCopyWithImpl;
@override @useResult
$Res call({
 ItemId itemId, TeamId teamId, UserId userId
});


@override $ItemIdCopyWith<$Res> get itemId;@override $TeamIdCopyWith<$Res> get teamId;@override $UserIdCopyWith<$Res> get userId;

}
/// @nodoc
class __$ItemPathCopyWithImpl<$Res>
    implements _$ItemPathCopyWith<$Res> {
  __$ItemPathCopyWithImpl(this._self, this._then);

  final _ItemPath _self;
  final $Res Function(_ItemPath) _then;

/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? teamId = null,Object? userId = null,}) {
  return _then(_ItemPath(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as ItemId,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,
  ));
}

/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemIdCopyWith<$Res> get itemId {
  
  return $ItemIdCopyWith<$Res>(_self.itemId, (value) {
    return _then(_self.copyWith(itemId: value));
  });
}/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}/// Create a copy of ItemPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}
}

// dart format on
