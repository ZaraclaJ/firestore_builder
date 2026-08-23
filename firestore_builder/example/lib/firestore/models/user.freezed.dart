// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

@JsonKey(name: User.nameFieldKey) String get name;@JsonKey(name: User.ageFieldKey) int get age;@JsonKey(name: User.currentJobFieldKey) String? get currentJob;@JsonKey(includeFromJson: false, includeToJson: false) UserId get userId;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.currentJob, currentJob) || other.currentJob == currentJob)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,currentJob,userId);

@override
String toString() {
  return 'User(name: $name, age: $age, currentJob: $currentJob, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: User.nameFieldKey) String name,@JsonKey(name: User.ageFieldKey) int age,@JsonKey(name: User.currentJobFieldKey) String? currentJob,@JsonKey(includeFromJson: false, includeToJson: false) UserId userId
});


$UserIdCopyWith<$Res> get userId;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? age = null,Object? currentJob = freezed,Object? userId = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,currentJob: freezed == currentJob ? _self.currentJob : currentJob // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: User.nameFieldKey)  String name, @JsonKey(name: User.ageFieldKey)  int age, @JsonKey(name: User.currentJobFieldKey)  String? currentJob, @JsonKey(includeFromJson: false, includeToJson: false)  UserId userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.name,_that.age,_that.currentJob,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: User.nameFieldKey)  String name, @JsonKey(name: User.ageFieldKey)  int age, @JsonKey(name: User.currentJobFieldKey)  String? currentJob, @JsonKey(includeFromJson: false, includeToJson: false)  UserId userId)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.name,_that.age,_that.currentJob,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: User.nameFieldKey)  String name, @JsonKey(name: User.ageFieldKey)  int age, @JsonKey(name: User.currentJobFieldKey)  String? currentJob, @JsonKey(includeFromJson: false, includeToJson: false)  UserId userId)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.name,_that.age,_that.currentJob,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({@JsonKey(name: User.nameFieldKey) required this.name, @JsonKey(name: User.ageFieldKey) required this.age, @JsonKey(name: User.currentJobFieldKey) this.currentJob, @JsonKey(includeFromJson: false, includeToJson: false) this.userId = const UserId('')}): super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: User.nameFieldKey) final  String name;
@override@JsonKey(name: User.ageFieldKey) final  int age;
@override@JsonKey(name: User.currentJobFieldKey) final  String? currentJob;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  UserId userId;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.name, name) || other.name == name)&&(identical(other.age, age) || other.age == age)&&(identical(other.currentJob, currentJob) || other.currentJob == currentJob)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,age,currentJob,userId);

@override
String toString() {
  return 'User(name: $name, age: $age, currentJob: $currentJob, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: User.nameFieldKey) String name,@JsonKey(name: User.ageFieldKey) int age,@JsonKey(name: User.currentJobFieldKey) String? currentJob,@JsonKey(includeFromJson: false, includeToJson: false) UserId userId
});


@override $UserIdCopyWith<$Res> get userId;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? age = null,Object? currentJob = freezed,Object? userId = null,}) {
  return _then(_User(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,age: null == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int,currentJob: freezed == currentJob ? _self.currentJob : currentJob // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}
}


/// @nodoc
mixin _$UserId {

 String get value;
/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserIdCopyWith<UserId> get copyWith => _$UserIdCopyWithImpl<UserId>(this as UserId, _$identity);

  /// Serializes this UserId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'UserId(value: $value)';
}


}

/// @nodoc
abstract mixin class $UserIdCopyWith<$Res>  {
  factory $UserIdCopyWith(UserId value, $Res Function(UserId) _then) = _$UserIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$UserIdCopyWithImpl<$Res>
    implements $UserIdCopyWith<$Res> {
  _$UserIdCopyWithImpl(this._self, this._then);

  final UserId _self;
  final $Res Function(UserId) _then;

/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserId].
extension UserIdPatterns on UserId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserId value)  $default,){
final _that = this;
switch (_that) {
case _UserId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserId value)?  $default,){
final _that = this;
switch (_that) {
case _UserId() when $default != null:
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
case _UserId() when $default != null:
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
case _UserId():
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
case _UserId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserId implements UserId {
  const _UserId(this.value);
  factory _UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);

@override final  String value;

/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserIdCopyWith<_UserId> get copyWith => __$UserIdCopyWithImpl<_UserId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'UserId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$UserIdCopyWith<$Res> implements $UserIdCopyWith<$Res> {
  factory _$UserIdCopyWith(_UserId value, $Res Function(_UserId) _then) = __$UserIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$UserIdCopyWithImpl<$Res>
    implements _$UserIdCopyWith<$Res> {
  __$UserIdCopyWithImpl(this._self, this._then);

  final _UserId _self;
  final $Res Function(_UserId) _then;

/// Create a copy of UserId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_UserId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserPath {

 UserId get userId; TeamId get teamId;
/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPathCopyWith<UserPath> get copyWith => _$UserPathCopyWithImpl<UserPath>(this as UserPath, _$identity);

  /// Serializes this UserPath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPath&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,teamId);

@override
String toString() {
  return 'UserPath(userId: $userId, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class $UserPathCopyWith<$Res>  {
  factory $UserPathCopyWith(UserPath value, $Res Function(UserPath) _then) = _$UserPathCopyWithImpl;
@useResult
$Res call({
 UserId userId, TeamId teamId
});


$UserIdCopyWith<$Res> get userId;$TeamIdCopyWith<$Res> get teamId;

}
/// @nodoc
class _$UserPathCopyWithImpl<$Res>
    implements $UserPathCopyWith<$Res> {
  _$UserPathCopyWithImpl(this._self, this._then);

  final UserPath _self;
  final $Res Function(UserPath) _then;

/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? teamId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,
  ));
}
/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserPath].
extension UserPathPatterns on UserPath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPath value)  $default,){
final _that = this;
switch (_that) {
case _UserPath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPath value)?  $default,){
final _that = this;
switch (_that) {
case _UserPath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserId userId,  TeamId teamId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPath() when $default != null:
return $default(_that.userId,_that.teamId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserId userId,  TeamId teamId)  $default,) {final _that = this;
switch (_that) {
case _UserPath():
return $default(_that.userId,_that.teamId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserId userId,  TeamId teamId)?  $default,) {final _that = this;
switch (_that) {
case _UserPath() when $default != null:
return $default(_that.userId,_that.teamId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPath implements UserPath {
  const _UserPath({required this.userId, required this.teamId});
  factory _UserPath.fromJson(Map<String, dynamic> json) => _$UserPathFromJson(json);

@override final  UserId userId;
@override final  TeamId teamId;

/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPathCopyWith<_UserPath> get copyWith => __$UserPathCopyWithImpl<_UserPath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPath&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,teamId);

@override
String toString() {
  return 'UserPath(userId: $userId, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class _$UserPathCopyWith<$Res> implements $UserPathCopyWith<$Res> {
  factory _$UserPathCopyWith(_UserPath value, $Res Function(_UserPath) _then) = __$UserPathCopyWithImpl;
@override @useResult
$Res call({
 UserId userId, TeamId teamId
});


@override $UserIdCopyWith<$Res> get userId;@override $TeamIdCopyWith<$Res> get teamId;

}
/// @nodoc
class __$UserPathCopyWithImpl<$Res>
    implements _$UserPathCopyWith<$Res> {
  __$UserPathCopyWithImpl(this._self, this._then);

  final _UserPath _self;
  final $Res Function(_UserPath) _then;

/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? teamId = null,}) {
  return _then(_UserPath(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as UserId,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,
  ));
}

/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserIdCopyWith<$Res> get userId {
  
  return $UserIdCopyWith<$Res>(_self.userId, (value) {
    return _then(_self.copyWith(userId: value));
  });
}/// Create a copy of UserPath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}
}

// dart format on
