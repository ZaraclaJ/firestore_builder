// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: User.nameFieldKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: User.ageFieldKey)
  int get age => throw _privateConstructorUsedError;
  @JsonKey(name: User.currentJobFieldKey)
  String? get currentJob => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserId get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: User.nameFieldKey) String name,
      @JsonKey(name: User.ageFieldKey) int age,
      @JsonKey(name: User.currentJobFieldKey) String? currentJob,
      @JsonKey(includeFromJson: false, includeToJson: false) UserId userId});

  $UserIdCopyWith<$Res> get userId;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? currentJob = freezed,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      currentJob: freezed == currentJob
          ? _value.currentJob
          : currentJob // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserId,
    ) as $Val);
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
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: User.nameFieldKey) String name,
      @JsonKey(name: User.ageFieldKey) int age,
      @JsonKey(name: User.currentJobFieldKey) String? currentJob,
      @JsonKey(includeFromJson: false, includeToJson: false) UserId userId});

  @override
  $UserIdCopyWith<$Res> get userId;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? currentJob = freezed,
    Object? userId = null,
  }) {
    return _then(_$UserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      currentJob: freezed == currentJob
          ? _value.currentJob
          : currentJob // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl extends _User {
  const _$UserImpl(
      {@JsonKey(name: User.nameFieldKey) required this.name,
      @JsonKey(name: User.ageFieldKey) required this.age,
      @JsonKey(name: User.currentJobFieldKey) this.currentJob,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.userId = const UserId('')})
      : super._();

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: User.nameFieldKey)
  final String name;
  @override
  @JsonKey(name: User.ageFieldKey)
  final int age;
  @override
  @JsonKey(name: User.currentJobFieldKey)
  final String? currentJob;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final UserId userId;

  @override
  String toString() {
    return 'User(name: $name, age: $age, currentJob: $currentJob, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.currentJob, currentJob) ||
                other.currentJob == currentJob) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, age, currentJob, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {@JsonKey(name: User.nameFieldKey) required final String name,
      @JsonKey(name: User.ageFieldKey) required final int age,
      @JsonKey(name: User.currentJobFieldKey) final String? currentJob,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final UserId userId}) = _$UserImpl;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: User.nameFieldKey)
  String get name;
  @override
  @JsonKey(name: User.ageFieldKey)
  int get age;
  @override
  @JsonKey(name: User.currentJobFieldKey)
  String? get currentJob;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  UserId get userId;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserId _$UserIdFromJson(Map<String, dynamic> json) {
  return _UserId.fromJson(json);
}

/// @nodoc
mixin _$UserId {
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserIdCopyWith<UserId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserIdCopyWith<$Res> {
  factory $UserIdCopyWith(UserId value, $Res Function(UserId) then) =
      _$UserIdCopyWithImpl<$Res, UserId>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$UserIdCopyWithImpl<$Res, $Val extends UserId>
    implements $UserIdCopyWith<$Res> {
  _$UserIdCopyWithImpl(this._value, this._then);

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
abstract class _$$UserIdImplCopyWith<$Res> implements $UserIdCopyWith<$Res> {
  factory _$$UserIdImplCopyWith(
          _$UserIdImpl value, $Res Function(_$UserIdImpl) then) =
      __$$UserIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$UserIdImplCopyWithImpl<$Res>
    extends _$UserIdCopyWithImpl<$Res, _$UserIdImpl>
    implements _$$UserIdImplCopyWith<$Res> {
  __$$UserIdImplCopyWithImpl(
      _$UserIdImpl _value, $Res Function(_$UserIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$UserIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserIdImpl implements _UserId {
  const _$UserIdImpl(this.value);

  factory _$UserIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserIdImplFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'UserId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserIdImplCopyWith<_$UserIdImpl> get copyWith =>
      __$$UserIdImplCopyWithImpl<_$UserIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserIdImplToJson(
      this,
    );
  }
}

abstract class _UserId implements UserId {
  const factory _UserId(final String value) = _$UserIdImpl;

  factory _UserId.fromJson(Map<String, dynamic> json) = _$UserIdImpl.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$UserIdImplCopyWith<_$UserIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserPath _$UserPathFromJson(Map<String, dynamic> json) {
  return _UserPath.fromJson(json);
}

/// @nodoc
mixin _$UserPath {
  UserId get userId => throw _privateConstructorUsedError;
  TeamId get teamId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserPathCopyWith<UserPath> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPathCopyWith<$Res> {
  factory $UserPathCopyWith(UserPath value, $Res Function(UserPath) then) =
      _$UserPathCopyWithImpl<$Res, UserPath>;
  @useResult
  $Res call({UserId userId, TeamId teamId});

  $UserIdCopyWith<$Res> get userId;
  $TeamIdCopyWith<$Res> get teamId;
}

/// @nodoc
class _$UserPathCopyWithImpl<$Res, $Val extends UserPath>
    implements $UserPathCopyWith<$Res> {
  _$UserPathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? teamId = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserId,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserIdCopyWith<$Res> get userId {
    return $UserIdCopyWith<$Res>(_value.userId, (value) {
      return _then(_value.copyWith(userId: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamIdCopyWith<$Res> get teamId {
    return $TeamIdCopyWith<$Res>(_value.teamId, (value) {
      return _then(_value.copyWith(teamId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserPathImplCopyWith<$Res>
    implements $UserPathCopyWith<$Res> {
  factory _$$UserPathImplCopyWith(
          _$UserPathImpl value, $Res Function(_$UserPathImpl) then) =
      __$$UserPathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserId userId, TeamId teamId});

  @override
  $UserIdCopyWith<$Res> get userId;
  @override
  $TeamIdCopyWith<$Res> get teamId;
}

/// @nodoc
class __$$UserPathImplCopyWithImpl<$Res>
    extends _$UserPathCopyWithImpl<$Res, _$UserPathImpl>
    implements _$$UserPathImplCopyWith<$Res> {
  __$$UserPathImplCopyWithImpl(
      _$UserPathImpl _value, $Res Function(_$UserPathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? teamId = null,
  }) {
    return _then(_$UserPathImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as UserId,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPathImpl implements _UserPath {
  const _$UserPathImpl({required this.userId, required this.teamId});

  factory _$UserPathImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPathImplFromJson(json);

  @override
  final UserId userId;
  @override
  final TeamId teamId;

  @override
  String toString() {
    return 'UserPath(userId: $userId, teamId: $teamId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPathImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, teamId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPathImplCopyWith<_$UserPathImpl> get copyWith =>
      __$$UserPathImplCopyWithImpl<_$UserPathImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPathImplToJson(
      this,
    );
  }
}

abstract class _UserPath implements UserPath {
  const factory _UserPath(
      {required final UserId userId,
      required final TeamId teamId}) = _$UserPathImpl;

  factory _UserPath.fromJson(Map<String, dynamic> json) =
      _$UserPathImpl.fromJson;

  @override
  UserId get userId;
  @override
  TeamId get teamId;
  @override
  @JsonKey(ignore: true)
  _$$UserPathImplCopyWith<_$UserPathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
