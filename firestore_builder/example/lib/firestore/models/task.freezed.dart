// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  @JsonKey(name: Task.nameFieldKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: Task.doneFieldKey)
  bool get done => throw _privateConstructorUsedError;
  @JsonKey(name: Task.descriptionFieldKey)
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TaskId get taskId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {@JsonKey(name: Task.nameFieldKey) String name,
      @JsonKey(name: Task.doneFieldKey) bool done,
      @JsonKey(name: Task.descriptionFieldKey) String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) TaskId taskId});

  $TaskIdCopyWith<$Res> get taskId;
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? done = null,
    Object? description = freezed,
    Object? taskId = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as TaskId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskIdCopyWith<$Res> get taskId {
    return $TaskIdCopyWith<$Res>(_value.taskId, (value) {
      return _then(_value.copyWith(taskId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: Task.nameFieldKey) String name,
      @JsonKey(name: Task.doneFieldKey) bool done,
      @JsonKey(name: Task.descriptionFieldKey) String? description,
      @JsonKey(includeFromJson: false, includeToJson: false) TaskId taskId});

  @override
  $TaskIdCopyWith<$Res> get taskId;
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? done = null,
    Object? description = freezed,
    Object? taskId = null,
  }) {
    return _then(_$TaskImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as TaskId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl extends _Task {
  const _$TaskImpl(
      {@JsonKey(name: Task.nameFieldKey) required this.name,
      @JsonKey(name: Task.doneFieldKey) required this.done,
      @JsonKey(name: Task.descriptionFieldKey) this.description,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.taskId = const TaskId('')})
      : super._();

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  @JsonKey(name: Task.nameFieldKey)
  final String name;
  @override
  @JsonKey(name: Task.doneFieldKey)
  final bool done;
  @override
  @JsonKey(name: Task.descriptionFieldKey)
  final String? description;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TaskId taskId;

  @override
  String toString() {
    return 'Task(name: $name, done: $done, description: $description, taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, done, description, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task extends Task {
  const factory _Task(
      {@JsonKey(name: Task.nameFieldKey) required final String name,
      @JsonKey(name: Task.doneFieldKey) required final bool done,
      @JsonKey(name: Task.descriptionFieldKey) final String? description,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TaskId taskId}) = _$TaskImpl;
  const _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  @JsonKey(name: Task.nameFieldKey)
  String get name;
  @override
  @JsonKey(name: Task.doneFieldKey)
  bool get done;
  @override
  @JsonKey(name: Task.descriptionFieldKey)
  String? get description;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TaskId get taskId;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskId _$TaskIdFromJson(Map<String, dynamic> json) {
  return _TaskId.fromJson(json);
}

/// @nodoc
mixin _$TaskId {
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskIdCopyWith<TaskId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskIdCopyWith<$Res> {
  factory $TaskIdCopyWith(TaskId value, $Res Function(TaskId) then) =
      _$TaskIdCopyWithImpl<$Res, TaskId>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$TaskIdCopyWithImpl<$Res, $Val extends TaskId>
    implements $TaskIdCopyWith<$Res> {
  _$TaskIdCopyWithImpl(this._value, this._then);

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
abstract class _$$TaskIdImplCopyWith<$Res> implements $TaskIdCopyWith<$Res> {
  factory _$$TaskIdImplCopyWith(
          _$TaskIdImpl value, $Res Function(_$TaskIdImpl) then) =
      __$$TaskIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$TaskIdImplCopyWithImpl<$Res>
    extends _$TaskIdCopyWithImpl<$Res, _$TaskIdImpl>
    implements _$$TaskIdImplCopyWith<$Res> {
  __$$TaskIdImplCopyWithImpl(
      _$TaskIdImpl _value, $Res Function(_$TaskIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$TaskIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskIdImpl implements _TaskId {
  const _$TaskIdImpl(this.value);

  factory _$TaskIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskIdImplFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'TaskId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskIdImplCopyWith<_$TaskIdImpl> get copyWith =>
      __$$TaskIdImplCopyWithImpl<_$TaskIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskIdImplToJson(
      this,
    );
  }
}

abstract class _TaskId implements TaskId {
  const factory _TaskId(final String value) = _$TaskIdImpl;

  factory _TaskId.fromJson(Map<String, dynamic> json) = _$TaskIdImpl.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$TaskIdImplCopyWith<_$TaskIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
