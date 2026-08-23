// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

@JsonKey(name: Task.nameFieldKey) String get name;@JsonKey(name: Task.doneFieldKey) bool get done;@JsonKey(name: Task.descriptionFieldKey) String? get description;@JsonKey(includeFromJson: false, includeToJson: false) TaskId get taskId;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.name, name) || other.name == name)&&(identical(other.done, done) || other.done == done)&&(identical(other.description, description) || other.description == description)&&(identical(other.taskId, taskId) || other.taskId == taskId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,done,description,taskId);

@override
String toString() {
  return 'Task(name: $name, done: $done, description: $description, taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: Task.nameFieldKey) String name,@JsonKey(name: Task.doneFieldKey) bool done,@JsonKey(name: Task.descriptionFieldKey) String? description,@JsonKey(includeFromJson: false, includeToJson: false) TaskId taskId
});


$TaskIdCopyWith<$Res> get taskId;

}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? done = null,Object? description = freezed,Object? taskId = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as TaskId,
  ));
}
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskIdCopyWith<$Res> get taskId {
  
  return $TaskIdCopyWith<$Res>(_self.taskId, (value) {
    return _then(_self.copyWith(taskId: value));
  });
}
}


/// Adds pattern-matching-related methods to [Task].
extension TaskPatterns on Task {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Task value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Task value)  $default,){
final _that = this;
switch (_that) {
case _Task():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Task value)?  $default,){
final _that = this;
switch (_that) {
case _Task() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: Task.nameFieldKey)  String name, @JsonKey(name: Task.doneFieldKey)  bool done, @JsonKey(name: Task.descriptionFieldKey)  String? description, @JsonKey(includeFromJson: false, includeToJson: false)  TaskId taskId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.name,_that.done,_that.description,_that.taskId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: Task.nameFieldKey)  String name, @JsonKey(name: Task.doneFieldKey)  bool done, @JsonKey(name: Task.descriptionFieldKey)  String? description, @JsonKey(includeFromJson: false, includeToJson: false)  TaskId taskId)  $default,) {final _that = this;
switch (_that) {
case _Task():
return $default(_that.name,_that.done,_that.description,_that.taskId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: Task.nameFieldKey)  String name, @JsonKey(name: Task.doneFieldKey)  bool done, @JsonKey(name: Task.descriptionFieldKey)  String? description, @JsonKey(includeFromJson: false, includeToJson: false)  TaskId taskId)?  $default,) {final _that = this;
switch (_that) {
case _Task() when $default != null:
return $default(_that.name,_that.done,_that.description,_that.taskId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Task extends Task {
  const _Task({@JsonKey(name: Task.nameFieldKey) required this.name, @JsonKey(name: Task.doneFieldKey) required this.done, @JsonKey(name: Task.descriptionFieldKey) this.description, @JsonKey(includeFromJson: false, includeToJson: false) this.taskId = const TaskId('')}): super._();
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override@JsonKey(name: Task.nameFieldKey) final  String name;
@override@JsonKey(name: Task.doneFieldKey) final  bool done;
@override@JsonKey(name: Task.descriptionFieldKey) final  String? description;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  TaskId taskId;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.name, name) || other.name == name)&&(identical(other.done, done) || other.done == done)&&(identical(other.description, description) || other.description == description)&&(identical(other.taskId, taskId) || other.taskId == taskId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,done,description,taskId);

@override
String toString() {
  return 'Task(name: $name, done: $done, description: $description, taskId: $taskId)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: Task.nameFieldKey) String name,@JsonKey(name: Task.doneFieldKey) bool done,@JsonKey(name: Task.descriptionFieldKey) String? description,@JsonKey(includeFromJson: false, includeToJson: false) TaskId taskId
});


@override $TaskIdCopyWith<$Res> get taskId;

}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? done = null,Object? description = freezed,Object? taskId = null,}) {
  return _then(_Task(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as TaskId,
  ));
}

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TaskIdCopyWith<$Res> get taskId {
  
  return $TaskIdCopyWith<$Res>(_self.taskId, (value) {
    return _then(_self.copyWith(taskId: value));
  });
}
}


/// @nodoc
mixin _$TaskId {

 String get value;
/// Create a copy of TaskId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskIdCopyWith<TaskId> get copyWith => _$TaskIdCopyWithImpl<TaskId>(this as TaskId, _$identity);

  /// Serializes this TaskId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'TaskId(value: $value)';
}


}

/// @nodoc
abstract mixin class $TaskIdCopyWith<$Res>  {
  factory $TaskIdCopyWith(TaskId value, $Res Function(TaskId) _then) = _$TaskIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$TaskIdCopyWithImpl<$Res>
    implements $TaskIdCopyWith<$Res> {
  _$TaskIdCopyWithImpl(this._self, this._then);

  final TaskId _self;
  final $Res Function(TaskId) _then;

/// Create a copy of TaskId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskId].
extension TaskIdPatterns on TaskId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskId value)  $default,){
final _that = this;
switch (_that) {
case _TaskId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskId value)?  $default,){
final _that = this;
switch (_that) {
case _TaskId() when $default != null:
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
case _TaskId() when $default != null:
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
case _TaskId():
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
case _TaskId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskId implements TaskId {
  const _TaskId(this.value);
  factory _TaskId.fromJson(Map<String, dynamic> json) => _$TaskIdFromJson(json);

@override final  String value;

/// Create a copy of TaskId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskIdCopyWith<_TaskId> get copyWith => __$TaskIdCopyWithImpl<_TaskId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'TaskId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$TaskIdCopyWith<$Res> implements $TaskIdCopyWith<$Res> {
  factory _$TaskIdCopyWith(_TaskId value, $Res Function(_TaskId) _then) = __$TaskIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$TaskIdCopyWithImpl<$Res>
    implements _$TaskIdCopyWith<$Res> {
  __$TaskIdCopyWithImpl(this._self, this._then);

  final _TaskId _self;
  final $Res Function(_TaskId) _then;

/// Create a copy of TaskId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_TaskId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
