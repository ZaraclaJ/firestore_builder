// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  @JsonKey(name: Team.nameFieldKey)
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: Team.userCountFieldKey)
  int get userCount => throw _privateConstructorUsedError;
  @DateTimeConverter()
  @JsonKey(name: Team.createdAtFieldKey)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: Team.labelsFieldKey)
  List<String> get labels => throw _privateConstructorUsedError;
  @JsonKey(name: Team.descriptionFieldKey)
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: Team.presencesFieldKey)
  Map<String, bool>? get presences => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  FieldValue? get createdAtFieldValue => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  FieldValue? get labelsFieldValue => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  TeamId get teamId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call(
      {@JsonKey(name: Team.nameFieldKey) String name,
      @JsonKey(name: Team.userCountFieldKey) int userCount,
      @DateTimeConverter()
      @JsonKey(name: Team.createdAtFieldKey)
      DateTime createdAt,
      @JsonKey(name: Team.labelsFieldKey) List<String> labels,
      @JsonKey(name: Team.descriptionFieldKey) String? description,
      @JsonKey(name: Team.presencesFieldKey) Map<String, bool>? presences,
      @JsonKey(includeFromJson: false, includeToJson: false)
      FieldValue? createdAtFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      FieldValue? labelsFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false) TeamId teamId});

  $TeamIdCopyWith<$Res> get teamId;
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? userCount = null,
    Object? createdAt = null,
    Object? labels = null,
    Object? description = freezed,
    Object? presences = freezed,
    Object? createdAtFieldValue = freezed,
    Object? labelsFieldValue = freezed,
    Object? teamId = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userCount: null == userCount
          ? _value.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      labels: null == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      presences: freezed == presences
          ? _value.presences
          : presences // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>?,
      createdAtFieldValue: freezed == createdAtFieldValue
          ? _value.createdAtFieldValue
          : createdAtFieldValue // ignore: cast_nullable_to_non_nullable
              as FieldValue?,
      labelsFieldValue: freezed == labelsFieldValue
          ? _value.labelsFieldValue
          : labelsFieldValue // ignore: cast_nullable_to_non_nullable
              as FieldValue?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
    ) as $Val);
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
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
          _$TeamImpl value, $Res Function(_$TeamImpl) then) =
      __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: Team.nameFieldKey) String name,
      @JsonKey(name: Team.userCountFieldKey) int userCount,
      @DateTimeConverter()
      @JsonKey(name: Team.createdAtFieldKey)
      DateTime createdAt,
      @JsonKey(name: Team.labelsFieldKey) List<String> labels,
      @JsonKey(name: Team.descriptionFieldKey) String? description,
      @JsonKey(name: Team.presencesFieldKey) Map<String, bool>? presences,
      @JsonKey(includeFromJson: false, includeToJson: false)
      FieldValue? createdAtFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      FieldValue? labelsFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false) TeamId teamId});

  @override
  $TeamIdCopyWith<$Res> get teamId;
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? userCount = null,
    Object? createdAt = null,
    Object? labels = null,
    Object? description = freezed,
    Object? presences = freezed,
    Object? createdAtFieldValue = freezed,
    Object? labelsFieldValue = freezed,
    Object? teamId = null,
  }) {
    return _then(_$TeamImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      userCount: null == userCount
          ? _value.userCount
          : userCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      labels: null == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      presences: freezed == presences
          ? _value._presences
          : presences // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>?,
      createdAtFieldValue: freezed == createdAtFieldValue
          ? _value.createdAtFieldValue
          : createdAtFieldValue // ignore: cast_nullable_to_non_nullable
              as FieldValue?,
      labelsFieldValue: freezed == labelsFieldValue
          ? _value.labelsFieldValue
          : labelsFieldValue // ignore: cast_nullable_to_non_nullable
              as FieldValue?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl extends _Team {
  const _$TeamImpl(
      {@JsonKey(name: Team.nameFieldKey) required this.name,
      @JsonKey(name: Team.userCountFieldKey) required this.userCount,
      @DateTimeConverter()
      @JsonKey(name: Team.createdAtFieldKey)
      required this.createdAt,
      @JsonKey(name: Team.labelsFieldKey) required final List<String> labels,
      @JsonKey(name: Team.descriptionFieldKey) this.description,
      @JsonKey(name: Team.presencesFieldKey) final Map<String, bool>? presences,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.createdAtFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.labelsFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.teamId = const TeamId('')})
      : _labels = labels,
        _presences = presences,
        super._();

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  @JsonKey(name: Team.nameFieldKey)
  final String name;
  @override
  @JsonKey(name: Team.userCountFieldKey)
  final int userCount;
  @override
  @DateTimeConverter()
  @JsonKey(name: Team.createdAtFieldKey)
  final DateTime createdAt;
  final List<String> _labels;
  @override
  @JsonKey(name: Team.labelsFieldKey)
  List<String> get labels {
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labels);
  }

  @override
  @JsonKey(name: Team.descriptionFieldKey)
  final String? description;
  final Map<String, bool>? _presences;
  @override
  @JsonKey(name: Team.presencesFieldKey)
  Map<String, bool>? get presences {
    final value = _presences;
    if (value == null) return null;
    if (_presences is EqualUnmodifiableMapView) return _presences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final FieldValue? createdAtFieldValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final FieldValue? labelsFieldValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final TeamId teamId;

  @override
  String toString() {
    return 'Team(name: $name, userCount: $userCount, createdAt: $createdAt, labels: $labels, description: $description, presences: $presences, createdAtFieldValue: $createdAtFieldValue, labelsFieldValue: $labelsFieldValue, teamId: $teamId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userCount, userCount) ||
                other.userCount == userCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._presences, _presences) &&
            (identical(other.createdAtFieldValue, createdAtFieldValue) ||
                other.createdAtFieldValue == createdAtFieldValue) &&
            (identical(other.labelsFieldValue, labelsFieldValue) ||
                other.labelsFieldValue == labelsFieldValue) &&
            (identical(other.teamId, teamId) || other.teamId == teamId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      userCount,
      createdAt,
      const DeepCollectionEquality().hash(_labels),
      description,
      const DeepCollectionEquality().hash(_presences),
      createdAtFieldValue,
      labelsFieldValue,
      teamId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(
      this,
    );
  }
}

abstract class _Team extends Team {
  const factory _Team(
      {@JsonKey(name: Team.nameFieldKey) required final String name,
      @JsonKey(name: Team.userCountFieldKey) required final int userCount,
      @DateTimeConverter()
      @JsonKey(name: Team.createdAtFieldKey)
      required final DateTime createdAt,
      @JsonKey(name: Team.labelsFieldKey) required final List<String> labels,
      @JsonKey(name: Team.descriptionFieldKey) final String? description,
      @JsonKey(name: Team.presencesFieldKey) final Map<String, bool>? presences,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final FieldValue? createdAtFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final FieldValue? labelsFieldValue,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final TeamId teamId}) = _$TeamImpl;
  const _Team._() : super._();

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  @JsonKey(name: Team.nameFieldKey)
  String get name;
  @override
  @JsonKey(name: Team.userCountFieldKey)
  int get userCount;
  @override
  @DateTimeConverter()
  @JsonKey(name: Team.createdAtFieldKey)
  DateTime get createdAt;
  @override
  @JsonKey(name: Team.labelsFieldKey)
  List<String> get labels;
  @override
  @JsonKey(name: Team.descriptionFieldKey)
  String? get description;
  @override
  @JsonKey(name: Team.presencesFieldKey)
  Map<String, bool>? get presences;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  FieldValue? get createdAtFieldValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  FieldValue? get labelsFieldValue;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  TeamId get teamId;
  @override
  @JsonKey(ignore: true)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamId _$TeamIdFromJson(Map<String, dynamic> json) {
  return _TeamId.fromJson(json);
}

/// @nodoc
mixin _$TeamId {
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamIdCopyWith<TeamId> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamIdCopyWith<$Res> {
  factory $TeamIdCopyWith(TeamId value, $Res Function(TeamId) then) =
      _$TeamIdCopyWithImpl<$Res, TeamId>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$TeamIdCopyWithImpl<$Res, $Val extends TeamId>
    implements $TeamIdCopyWith<$Res> {
  _$TeamIdCopyWithImpl(this._value, this._then);

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
abstract class _$$TeamIdImplCopyWith<$Res> implements $TeamIdCopyWith<$Res> {
  factory _$$TeamIdImplCopyWith(
          _$TeamIdImpl value, $Res Function(_$TeamIdImpl) then) =
      __$$TeamIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$TeamIdImplCopyWithImpl<$Res>
    extends _$TeamIdCopyWithImpl<$Res, _$TeamIdImpl>
    implements _$$TeamIdImplCopyWith<$Res> {
  __$$TeamIdImplCopyWithImpl(
      _$TeamIdImpl _value, $Res Function(_$TeamIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$TeamIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamIdImpl implements _TeamId {
  const _$TeamIdImpl(this.value);

  factory _$TeamIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamIdImplFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'TeamId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamIdImplCopyWith<_$TeamIdImpl> get copyWith =>
      __$$TeamIdImplCopyWithImpl<_$TeamIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamIdImplToJson(
      this,
    );
  }
}

abstract class _TeamId implements TeamId {
  const factory _TeamId(final String value) = _$TeamIdImpl;

  factory _TeamId.fromJson(Map<String, dynamic> json) = _$TeamIdImpl.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$TeamIdImplCopyWith<_$TeamIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
