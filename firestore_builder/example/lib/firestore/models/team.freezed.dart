// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Team {

@JsonKey(name: Team.nameFieldKey) String get name;@JsonKey(name: Team.userCountFieldKey) int get userCount;@DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey) DateTime get createdAt;@JsonKey(name: Team.labelsFieldKey) List<String> get labels;@JsonKey(name: Team.teamSizeFieldKey) TeamSize get teamSize;@JsonKey(name: Team.descriptionFieldKey) String? get description;@TimestampConverter()@JsonKey(name: Team.datesFieldKey) List<Timestamp?>? get dates;@JsonKey(name: Team.bytesFieldKey) List<List<int>>? get bytes;@JsonKey(name: Team.presencesFieldKey) Map<String, bool>? get presences;@DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey) DocumentReference? get teamRef;@JsonKey(includeFromJson: false, includeToJson: false) FieldValue? get createdAtFieldValue;@JsonKey(includeFromJson: false, includeToJson: false) FieldValue? get labelsFieldValue;@JsonKey(includeFromJson: false, includeToJson: false) TeamId get teamId;
/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamCopyWith<Team> get copyWith => _$TeamCopyWithImpl<Team>(this as Team, _$identity);

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Team&&(identical(other.name, name) || other.name == name)&&(identical(other.userCount, userCount) || other.userCount == userCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.labels, labels)&&(identical(other.teamSize, teamSize) || other.teamSize == teamSize)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.dates, dates)&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other.presences, presences)&&(identical(other.teamRef, teamRef) || other.teamRef == teamRef)&&(identical(other.createdAtFieldValue, createdAtFieldValue) || other.createdAtFieldValue == createdAtFieldValue)&&(identical(other.labelsFieldValue, labelsFieldValue) || other.labelsFieldValue == labelsFieldValue)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,userCount,createdAt,const DeepCollectionEquality().hash(labels),teamSize,description,const DeepCollectionEquality().hash(dates),const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(presences),teamRef,createdAtFieldValue,labelsFieldValue,teamId);

@override
String toString() {
  return 'Team(name: $name, userCount: $userCount, createdAt: $createdAt, labels: $labels, teamSize: $teamSize, description: $description, dates: $dates, bytes: $bytes, presences: $presences, teamRef: $teamRef, createdAtFieldValue: $createdAtFieldValue, labelsFieldValue: $labelsFieldValue, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class $TeamCopyWith<$Res>  {
  factory $TeamCopyWith(Team value, $Res Function(Team) _then) = _$TeamCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: Team.nameFieldKey) String name,@JsonKey(name: Team.userCountFieldKey) int userCount,@DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey) DateTime createdAt,@JsonKey(name: Team.labelsFieldKey) List<String> labels,@JsonKey(name: Team.teamSizeFieldKey) TeamSize teamSize,@JsonKey(name: Team.descriptionFieldKey) String? description,@TimestampConverter()@JsonKey(name: Team.datesFieldKey) List<Timestamp?>? dates,@JsonKey(name: Team.bytesFieldKey) List<List<int>>? bytes,@JsonKey(name: Team.presencesFieldKey) Map<String, bool>? presences,@DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey) DocumentReference? teamRef,@JsonKey(includeFromJson: false, includeToJson: false) FieldValue? createdAtFieldValue,@JsonKey(includeFromJson: false, includeToJson: false) FieldValue? labelsFieldValue,@JsonKey(includeFromJson: false, includeToJson: false) TeamId teamId
});


$TeamIdCopyWith<$Res> get teamId;

}
/// @nodoc
class _$TeamCopyWithImpl<$Res>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._self, this._then);

  final Team _self;
  final $Res Function(Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? userCount = null,Object? createdAt = null,Object? labels = null,Object? teamSize = null,Object? description = freezed,Object? dates = freezed,Object? bytes = freezed,Object? presences = freezed,Object? teamRef = freezed,Object? createdAtFieldValue = freezed,Object? labelsFieldValue = freezed,Object? teamId = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,teamSize: null == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as TeamSize,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dates: freezed == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<Timestamp?>?,bytes: freezed == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,presences: freezed == presences ? _self.presences : presences // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,teamRef: freezed == teamRef ? _self.teamRef : teamRef // ignore: cast_nullable_to_non_nullable
as DocumentReference?,createdAtFieldValue: freezed == createdAtFieldValue ? _self.createdAtFieldValue : createdAtFieldValue // ignore: cast_nullable_to_non_nullable
as FieldValue?,labelsFieldValue: freezed == labelsFieldValue ? _self.labelsFieldValue : labelsFieldValue // ignore: cast_nullable_to_non_nullable
as FieldValue?,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,
  ));
}
/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}
}


/// Adds pattern-matching-related methods to [Team].
extension TeamPatterns on Team {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Team value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Team value)  $default,){
final _that = this;
switch (_that) {
case _Team():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Team value)?  $default,){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: Team.nameFieldKey)  String name, @JsonKey(name: Team.userCountFieldKey)  int userCount, @DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey)  DateTime createdAt, @JsonKey(name: Team.labelsFieldKey)  List<String> labels, @JsonKey(name: Team.teamSizeFieldKey)  TeamSize teamSize, @JsonKey(name: Team.descriptionFieldKey)  String? description, @TimestampConverter()@JsonKey(name: Team.datesFieldKey)  List<Timestamp?>? dates, @JsonKey(name: Team.bytesFieldKey)  List<List<int>>? bytes, @JsonKey(name: Team.presencesFieldKey)  Map<String, bool>? presences, @DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey)  DocumentReference? teamRef, @JsonKey(includeFromJson: false, includeToJson: false)  FieldValue? createdAtFieldValue, @JsonKey(includeFromJson: false, includeToJson: false)  FieldValue? labelsFieldValue, @JsonKey(includeFromJson: false, includeToJson: false)  TeamId teamId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.name,_that.userCount,_that.createdAt,_that.labels,_that.teamSize,_that.description,_that.dates,_that.bytes,_that.presences,_that.teamRef,_that.createdAtFieldValue,_that.labelsFieldValue,_that.teamId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: Team.nameFieldKey)  String name, @JsonKey(name: Team.userCountFieldKey)  int userCount, @DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey)  DateTime createdAt, @JsonKey(name: Team.labelsFieldKey)  List<String> labels, @JsonKey(name: Team.teamSizeFieldKey)  TeamSize teamSize, @JsonKey(name: Team.descriptionFieldKey)  String? description, @TimestampConverter()@JsonKey(name: Team.datesFieldKey)  List<Timestamp?>? dates, @JsonKey(name: Team.bytesFieldKey)  List<List<int>>? bytes, @JsonKey(name: Team.presencesFieldKey)  Map<String, bool>? presences, @DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey)  DocumentReference? teamRef, @JsonKey(includeFromJson: false, includeToJson: false)  FieldValue? createdAtFieldValue, @JsonKey(includeFromJson: false, includeToJson: false)  FieldValue? labelsFieldValue, @JsonKey(includeFromJson: false, includeToJson: false)  TeamId teamId)  $default,) {final _that = this;
switch (_that) {
case _Team():
return $default(_that.name,_that.userCount,_that.createdAt,_that.labels,_that.teamSize,_that.description,_that.dates,_that.bytes,_that.presences,_that.teamRef,_that.createdAtFieldValue,_that.labelsFieldValue,_that.teamId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: Team.nameFieldKey)  String name, @JsonKey(name: Team.userCountFieldKey)  int userCount, @DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey)  DateTime createdAt, @JsonKey(name: Team.labelsFieldKey)  List<String> labels, @JsonKey(name: Team.teamSizeFieldKey)  TeamSize teamSize, @JsonKey(name: Team.descriptionFieldKey)  String? description, @TimestampConverter()@JsonKey(name: Team.datesFieldKey)  List<Timestamp?>? dates, @JsonKey(name: Team.bytesFieldKey)  List<List<int>>? bytes, @JsonKey(name: Team.presencesFieldKey)  Map<String, bool>? presences, @DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey)  DocumentReference? teamRef, @JsonKey(includeFromJson: false, includeToJson: false)  FieldValue? createdAtFieldValue, @JsonKey(includeFromJson: false, includeToJson: false)  FieldValue? labelsFieldValue, @JsonKey(includeFromJson: false, includeToJson: false)  TeamId teamId)?  $default,) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.name,_that.userCount,_that.createdAt,_that.labels,_that.teamSize,_that.description,_that.dates,_that.bytes,_that.presences,_that.teamRef,_that.createdAtFieldValue,_that.labelsFieldValue,_that.teamId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Team extends Team {
  const _Team({@JsonKey(name: Team.nameFieldKey) required this.name, @JsonKey(name: Team.userCountFieldKey) required this.userCount, @DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey) required this.createdAt, @JsonKey(name: Team.labelsFieldKey) required final  List<String> labels, @JsonKey(name: Team.teamSizeFieldKey) required this.teamSize, @JsonKey(name: Team.descriptionFieldKey) this.description, @TimestampConverter()@JsonKey(name: Team.datesFieldKey) final  List<Timestamp?>? dates, @JsonKey(name: Team.bytesFieldKey) final  List<List<int>>? bytes, @JsonKey(name: Team.presencesFieldKey) final  Map<String, bool>? presences, @DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey) this.teamRef, @JsonKey(includeFromJson: false, includeToJson: false) this.createdAtFieldValue, @JsonKey(includeFromJson: false, includeToJson: false) this.labelsFieldValue, @JsonKey(includeFromJson: false, includeToJson: false) this.teamId = const TeamId('')}): _labels = labels,_dates = dates,_bytes = bytes,_presences = presences,super._();
  factory _Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

@override@JsonKey(name: Team.nameFieldKey) final  String name;
@override@JsonKey(name: Team.userCountFieldKey) final  int userCount;
@override@DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey) final  DateTime createdAt;
 final  List<String> _labels;
@override@JsonKey(name: Team.labelsFieldKey) List<String> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

@override@JsonKey(name: Team.teamSizeFieldKey) final  TeamSize teamSize;
@override@JsonKey(name: Team.descriptionFieldKey) final  String? description;
 final  List<Timestamp?>? _dates;
@override@TimestampConverter()@JsonKey(name: Team.datesFieldKey) List<Timestamp?>? get dates {
  final value = _dates;
  if (value == null) return null;
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<List<int>>? _bytes;
@override@JsonKey(name: Team.bytesFieldKey) List<List<int>>? get bytes {
  final value = _bytes;
  if (value == null) return null;
  if (_bytes is EqualUnmodifiableListView) return _bytes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, bool>? _presences;
@override@JsonKey(name: Team.presencesFieldKey) Map<String, bool>? get presences {
  final value = _presences;
  if (value == null) return null;
  if (_presences is EqualUnmodifiableMapView) return _presences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey) final  DocumentReference? teamRef;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  FieldValue? createdAtFieldValue;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  FieldValue? labelsFieldValue;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  TeamId teamId;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamCopyWith<_Team> get copyWith => __$TeamCopyWithImpl<_Team>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Team&&(identical(other.name, name) || other.name == name)&&(identical(other.userCount, userCount) || other.userCount == userCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._labels, _labels)&&(identical(other.teamSize, teamSize) || other.teamSize == teamSize)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._dates, _dates)&&const DeepCollectionEquality().equals(other._bytes, _bytes)&&const DeepCollectionEquality().equals(other._presences, _presences)&&(identical(other.teamRef, teamRef) || other.teamRef == teamRef)&&(identical(other.createdAtFieldValue, createdAtFieldValue) || other.createdAtFieldValue == createdAtFieldValue)&&(identical(other.labelsFieldValue, labelsFieldValue) || other.labelsFieldValue == labelsFieldValue)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,userCount,createdAt,const DeepCollectionEquality().hash(_labels),teamSize,description,const DeepCollectionEquality().hash(_dates),const DeepCollectionEquality().hash(_bytes),const DeepCollectionEquality().hash(_presences),teamRef,createdAtFieldValue,labelsFieldValue,teamId);

@override
String toString() {
  return 'Team(name: $name, userCount: $userCount, createdAt: $createdAt, labels: $labels, teamSize: $teamSize, description: $description, dates: $dates, bytes: $bytes, presences: $presences, teamRef: $teamRef, createdAtFieldValue: $createdAtFieldValue, labelsFieldValue: $labelsFieldValue, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class _$TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$TeamCopyWith(_Team value, $Res Function(_Team) _then) = __$TeamCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: Team.nameFieldKey) String name,@JsonKey(name: Team.userCountFieldKey) int userCount,@DateTimeConverter()@JsonKey(name: Team.createdAtFieldKey) DateTime createdAt,@JsonKey(name: Team.labelsFieldKey) List<String> labels,@JsonKey(name: Team.teamSizeFieldKey) TeamSize teamSize,@JsonKey(name: Team.descriptionFieldKey) String? description,@TimestampConverter()@JsonKey(name: Team.datesFieldKey) List<Timestamp?>? dates,@JsonKey(name: Team.bytesFieldKey) List<List<int>>? bytes,@JsonKey(name: Team.presencesFieldKey) Map<String, bool>? presences,@DocumentReferenceConverter()@JsonKey(name: Team.teamRefFieldKey) DocumentReference? teamRef,@JsonKey(includeFromJson: false, includeToJson: false) FieldValue? createdAtFieldValue,@JsonKey(includeFromJson: false, includeToJson: false) FieldValue? labelsFieldValue,@JsonKey(includeFromJson: false, includeToJson: false) TeamId teamId
});


@override $TeamIdCopyWith<$Res> get teamId;

}
/// @nodoc
class __$TeamCopyWithImpl<$Res>
    implements _$TeamCopyWith<$Res> {
  __$TeamCopyWithImpl(this._self, this._then);

  final _Team _self;
  final $Res Function(_Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? userCount = null,Object? createdAt = null,Object? labels = null,Object? teamSize = null,Object? description = freezed,Object? dates = freezed,Object? bytes = freezed,Object? presences = freezed,Object? teamRef = freezed,Object? createdAtFieldValue = freezed,Object? labelsFieldValue = freezed,Object? teamId = null,}) {
  return _then(_Team(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<String>,teamSize: null == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as TeamSize,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,dates: freezed == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<Timestamp?>?,bytes: freezed == bytes ? _self._bytes : bytes // ignore: cast_nullable_to_non_nullable
as List<List<int>>?,presences: freezed == presences ? _self._presences : presences // ignore: cast_nullable_to_non_nullable
as Map<String, bool>?,teamRef: freezed == teamRef ? _self.teamRef : teamRef // ignore: cast_nullable_to_non_nullable
as DocumentReference?,createdAtFieldValue: freezed == createdAtFieldValue ? _self.createdAtFieldValue : createdAtFieldValue // ignore: cast_nullable_to_non_nullable
as FieldValue?,labelsFieldValue: freezed == labelsFieldValue ? _self.labelsFieldValue : labelsFieldValue // ignore: cast_nullable_to_non_nullable
as FieldValue?,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,
  ));
}

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}
}


/// @nodoc
mixin _$TeamId {

 String get value;
/// Create a copy of TeamId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamIdCopyWith<TeamId> get copyWith => _$TeamIdCopyWithImpl<TeamId>(this as TeamId, _$identity);

  /// Serializes this TeamId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'TeamId(value: $value)';
}


}

/// @nodoc
abstract mixin class $TeamIdCopyWith<$Res>  {
  factory $TeamIdCopyWith(TeamId value, $Res Function(TeamId) _then) = _$TeamIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$TeamIdCopyWithImpl<$Res>
    implements $TeamIdCopyWith<$Res> {
  _$TeamIdCopyWithImpl(this._self, this._then);

  final TeamId _self;
  final $Res Function(TeamId) _then;

/// Create a copy of TeamId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamId].
extension TeamIdPatterns on TeamId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamId value)  $default,){
final _that = this;
switch (_that) {
case _TeamId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamId value)?  $default,){
final _that = this;
switch (_that) {
case _TeamId() when $default != null:
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
case _TeamId() when $default != null:
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
case _TeamId():
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
case _TeamId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamId implements TeamId {
  const _TeamId(this.value);
  factory _TeamId.fromJson(Map<String, dynamic> json) => _$TeamIdFromJson(json);

@override final  String value;

/// Create a copy of TeamId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamIdCopyWith<_TeamId> get copyWith => __$TeamIdCopyWithImpl<_TeamId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'TeamId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$TeamIdCopyWith<$Res> implements $TeamIdCopyWith<$Res> {
  factory _$TeamIdCopyWith(_TeamId value, $Res Function(_TeamId) _then) = __$TeamIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$TeamIdCopyWithImpl<$Res>
    implements _$TeamIdCopyWith<$Res> {
  __$TeamIdCopyWithImpl(this._self, this._then);

  final _TeamId _self;
  final $Res Function(_TeamId) _then;

/// Create a copy of TeamId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_TeamId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
