// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  @JsonKey(name: Message.contentFieldKey)
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: Message.dateFieldKey)
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  MessageId get messageId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {@JsonKey(name: Message.contentFieldKey) String content,
      @JsonKey(name: Message.dateFieldKey) DateTime date,
      @JsonKey(includeFromJson: false, includeToJson: false)
      MessageId messageId});

  $MessageIdCopyWith<$Res> get messageId;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? date = null,
    Object? messageId = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as MessageId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageIdCopyWith<$Res> get messageId {
    return $MessageIdCopyWith<$Res>(_value.messageId, (value) {
      return _then(_value.copyWith(messageId: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: Message.contentFieldKey) String content,
      @JsonKey(name: Message.dateFieldKey) DateTime date,
      @JsonKey(includeFromJson: false, includeToJson: false)
      MessageId messageId});

  @override
  $MessageIdCopyWith<$Res> get messageId;
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? date = null,
    Object? messageId = null,
  }) {
    return _then(_$MessageImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as MessageId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl extends _Message {
  const _$MessageImpl(
      {@JsonKey(name: Message.contentFieldKey) required this.content,
      @JsonKey(name: Message.dateFieldKey) required this.date,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.messageId = const MessageId('')})
      : super._();

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  @JsonKey(name: Message.contentFieldKey)
  final String content;
  @override
  @JsonKey(name: Message.dateFieldKey)
  final DateTime date;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final MessageId messageId;

  @override
  String toString() {
    return 'Message(content: $content, date: $date, messageId: $messageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, content, date, messageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message extends Message {
  const factory _Message(
      {@JsonKey(name: Message.contentFieldKey) required final String content,
      @JsonKey(name: Message.dateFieldKey) required final DateTime date,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final MessageId messageId}) = _$MessageImpl;
  const _Message._() : super._();

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  @JsonKey(name: Message.contentFieldKey)
  String get content;
  @override
  @JsonKey(name: Message.dateFieldKey)
  DateTime get date;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  MessageId get messageId;
  @override
  @JsonKey(ignore: true)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageId _$MessageIdFromJson(Map<String, dynamic> json) {
  return _MessageId.fromJson(json);
}

/// @nodoc
mixin _$MessageId {
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageIdCopyWith<MessageId> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageIdCopyWith<$Res> {
  factory $MessageIdCopyWith(MessageId value, $Res Function(MessageId) then) =
      _$MessageIdCopyWithImpl<$Res, MessageId>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$MessageIdCopyWithImpl<$Res, $Val extends MessageId>
    implements $MessageIdCopyWith<$Res> {
  _$MessageIdCopyWithImpl(this._value, this._then);

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
abstract class _$$MessageIdImplCopyWith<$Res>
    implements $MessageIdCopyWith<$Res> {
  factory _$$MessageIdImplCopyWith(
          _$MessageIdImpl value, $Res Function(_$MessageIdImpl) then) =
      __$$MessageIdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$MessageIdImplCopyWithImpl<$Res>
    extends _$MessageIdCopyWithImpl<$Res, _$MessageIdImpl>
    implements _$$MessageIdImplCopyWith<$Res> {
  __$$MessageIdImplCopyWithImpl(
      _$MessageIdImpl _value, $Res Function(_$MessageIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$MessageIdImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageIdImpl implements _MessageId {
  const _$MessageIdImpl(this.value);

  factory _$MessageIdImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageIdImplFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'MessageId(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageIdImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageIdImplCopyWith<_$MessageIdImpl> get copyWith =>
      __$$MessageIdImplCopyWithImpl<_$MessageIdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageIdImplToJson(
      this,
    );
  }
}

abstract class _MessageId implements MessageId {
  const factory _MessageId(final String value) = _$MessageIdImpl;

  factory _MessageId.fromJson(Map<String, dynamic> json) =
      _$MessageIdImpl.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$MessageIdImplCopyWith<_$MessageIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessagePath _$MessagePathFromJson(Map<String, dynamic> json) {
  return _MessagePath.fromJson(json);
}

/// @nodoc
mixin _$MessagePath {
  MessageId get messageId => throw _privateConstructorUsedError;
  TeamId get teamId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagePathCopyWith<MessagePath> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagePathCopyWith<$Res> {
  factory $MessagePathCopyWith(
          MessagePath value, $Res Function(MessagePath) then) =
      _$MessagePathCopyWithImpl<$Res, MessagePath>;
  @useResult
  $Res call({MessageId messageId, TeamId teamId});

  $MessageIdCopyWith<$Res> get messageId;
  $TeamIdCopyWith<$Res> get teamId;
}

/// @nodoc
class _$MessagePathCopyWithImpl<$Res, $Val extends MessagePath>
    implements $MessagePathCopyWith<$Res> {
  _$MessagePathCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? teamId = null,
  }) {
    return _then(_value.copyWith(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as MessageId,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageIdCopyWith<$Res> get messageId {
    return $MessageIdCopyWith<$Res>(_value.messageId, (value) {
      return _then(_value.copyWith(messageId: value) as $Val);
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
abstract class _$$MessagePathImplCopyWith<$Res>
    implements $MessagePathCopyWith<$Res> {
  factory _$$MessagePathImplCopyWith(
          _$MessagePathImpl value, $Res Function(_$MessagePathImpl) then) =
      __$$MessagePathImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MessageId messageId, TeamId teamId});

  @override
  $MessageIdCopyWith<$Res> get messageId;
  @override
  $TeamIdCopyWith<$Res> get teamId;
}

/// @nodoc
class __$$MessagePathImplCopyWithImpl<$Res>
    extends _$MessagePathCopyWithImpl<$Res, _$MessagePathImpl>
    implements _$$MessagePathImplCopyWith<$Res> {
  __$$MessagePathImplCopyWithImpl(
      _$MessagePathImpl _value, $Res Function(_$MessagePathImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? teamId = null,
  }) {
    return _then(_$MessagePathImpl(
      messageId: null == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as MessageId,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as TeamId,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessagePathImpl implements _MessagePath {
  const _$MessagePathImpl({required this.messageId, required this.teamId});

  factory _$MessagePathImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessagePathImplFromJson(json);

  @override
  final MessageId messageId;
  @override
  final TeamId teamId;

  @override
  String toString() {
    return 'MessagePath(messageId: $messageId, teamId: $teamId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessagePathImpl &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, teamId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessagePathImplCopyWith<_$MessagePathImpl> get copyWith =>
      __$$MessagePathImplCopyWithImpl<_$MessagePathImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessagePathImplToJson(
      this,
    );
  }
}

abstract class _MessagePath implements MessagePath {
  const factory _MessagePath(
      {required final MessageId messageId,
      required final TeamId teamId}) = _$MessagePathImpl;

  factory _MessagePath.fromJson(Map<String, dynamic> json) =
      _$MessagePathImpl.fromJson;

  @override
  MessageId get messageId;
  @override
  TeamId get teamId;
  @override
  @JsonKey(ignore: true)
  _$$MessagePathImplCopyWith<_$MessagePathImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
