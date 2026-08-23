// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Message {

@JsonKey(name: Message.contentFieldKey) String get content;@TimestampConverter()@JsonKey(name: Message.dateFieldKey) Timestamp? get date;@JsonKey(includeFromJson: false, includeToJson: false) MessageId get messageId;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.content, content) || other.content == content)&&(identical(other.date, date) || other.date == date)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,date,messageId);

@override
String toString() {
  return 'Message(content: $content, date: $date, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: Message.contentFieldKey) String content,@TimestampConverter()@JsonKey(name: Message.dateFieldKey) Timestamp? date,@JsonKey(includeFromJson: false, includeToJson: false) MessageId messageId
});


$MessageIdCopyWith<$Res> get messageId;

}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? date = freezed,Object? messageId = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as Timestamp?,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as MessageId,
  ));
}
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageIdCopyWith<$Res> get messageId {
  
  return $MessageIdCopyWith<$Res>(_self.messageId, (value) {
    return _then(_self.copyWith(messageId: value));
  });
}
}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message value)  $default,){
final _that = this;
switch (_that) {
case _Message():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: Message.contentFieldKey)  String content, @TimestampConverter()@JsonKey(name: Message.dateFieldKey)  Timestamp? date, @JsonKey(includeFromJson: false, includeToJson: false)  MessageId messageId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.content,_that.date,_that.messageId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: Message.contentFieldKey)  String content, @TimestampConverter()@JsonKey(name: Message.dateFieldKey)  Timestamp? date, @JsonKey(includeFromJson: false, includeToJson: false)  MessageId messageId)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.content,_that.date,_that.messageId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: Message.contentFieldKey)  String content, @TimestampConverter()@JsonKey(name: Message.dateFieldKey)  Timestamp? date, @JsonKey(includeFromJson: false, includeToJson: false)  MessageId messageId)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.content,_that.date,_that.messageId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Message extends Message {
  const _Message({@JsonKey(name: Message.contentFieldKey) required this.content, @TimestampConverter()@JsonKey(name: Message.dateFieldKey) this.date, @JsonKey(includeFromJson: false, includeToJson: false) this.messageId = const MessageId('')}): super._();
  factory _Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

@override@JsonKey(name: Message.contentFieldKey) final  String content;
@override@TimestampConverter()@JsonKey(name: Message.dateFieldKey) final  Timestamp? date;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  MessageId messageId;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<_Message> get copyWith => __$MessageCopyWithImpl<_Message>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.content, content) || other.content == content)&&(identical(other.date, date) || other.date == date)&&(identical(other.messageId, messageId) || other.messageId == messageId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,date,messageId);

@override
String toString() {
  return 'Message(content: $content, date: $date, messageId: $messageId)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: Message.contentFieldKey) String content,@TimestampConverter()@JsonKey(name: Message.dateFieldKey) Timestamp? date,@JsonKey(includeFromJson: false, includeToJson: false) MessageId messageId
});


@override $MessageIdCopyWith<$Res> get messageId;

}
/// @nodoc
class __$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? date = freezed,Object? messageId = null,}) {
  return _then(_Message(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as Timestamp?,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as MessageId,
  ));
}

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageIdCopyWith<$Res> get messageId {
  
  return $MessageIdCopyWith<$Res>(_self.messageId, (value) {
    return _then(_self.copyWith(messageId: value));
  });
}
}


/// @nodoc
mixin _$MessageId {

 String get value;
/// Create a copy of MessageId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageIdCopyWith<MessageId> get copyWith => _$MessageIdCopyWithImpl<MessageId>(this as MessageId, _$identity);

  /// Serializes this MessageId to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'MessageId(value: $value)';
}


}

/// @nodoc
abstract mixin class $MessageIdCopyWith<$Res>  {
  factory $MessageIdCopyWith(MessageId value, $Res Function(MessageId) _then) = _$MessageIdCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$MessageIdCopyWithImpl<$Res>
    implements $MessageIdCopyWith<$Res> {
  _$MessageIdCopyWithImpl(this._self, this._then);

  final MessageId _self;
  final $Res Function(MessageId) _then;

/// Create a copy of MessageId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageId].
extension MessageIdPatterns on MessageId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageId() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageId value)  $default,){
final _that = this;
switch (_that) {
case _MessageId():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageId value)?  $default,){
final _that = this;
switch (_that) {
case _MessageId() when $default != null:
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
case _MessageId() when $default != null:
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
case _MessageId():
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
case _MessageId() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageId implements MessageId {
  const _MessageId(this.value);
  factory _MessageId.fromJson(Map<String, dynamic> json) => _$MessageIdFromJson(json);

@override final  String value;

/// Create a copy of MessageId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageIdCopyWith<_MessageId> get copyWith => __$MessageIdCopyWithImpl<_MessageId>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageIdToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageId&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'MessageId(value: $value)';
}


}

/// @nodoc
abstract mixin class _$MessageIdCopyWith<$Res> implements $MessageIdCopyWith<$Res> {
  factory _$MessageIdCopyWith(_MessageId value, $Res Function(_MessageId) _then) = __$MessageIdCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$MessageIdCopyWithImpl<$Res>
    implements _$MessageIdCopyWith<$Res> {
  __$MessageIdCopyWithImpl(this._self, this._then);

  final _MessageId _self;
  final $Res Function(_MessageId) _then;

/// Create a copy of MessageId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_MessageId(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MessagePath {

 MessageId get messageId; TeamId get teamId;
/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagePathCopyWith<MessagePath> get copyWith => _$MessagePathCopyWithImpl<MessagePath>(this as MessagePath, _$identity);

  /// Serializes this MessagePath to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagePath&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,teamId);

@override
String toString() {
  return 'MessagePath(messageId: $messageId, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class $MessagePathCopyWith<$Res>  {
  factory $MessagePathCopyWith(MessagePath value, $Res Function(MessagePath) _then) = _$MessagePathCopyWithImpl;
@useResult
$Res call({
 MessageId messageId, TeamId teamId
});


$MessageIdCopyWith<$Res> get messageId;$TeamIdCopyWith<$Res> get teamId;

}
/// @nodoc
class _$MessagePathCopyWithImpl<$Res>
    implements $MessagePathCopyWith<$Res> {
  _$MessagePathCopyWithImpl(this._self, this._then);

  final MessagePath _self;
  final $Res Function(MessagePath) _then;

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messageId = null,Object? teamId = null,}) {
  return _then(_self.copyWith(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as MessageId,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,
  ));
}
/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageIdCopyWith<$Res> get messageId {
  
  return $MessageIdCopyWith<$Res>(_self.messageId, (value) {
    return _then(_self.copyWith(messageId: value));
  });
}/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamIdCopyWith<$Res> get teamId {
  
  return $TeamIdCopyWith<$Res>(_self.teamId, (value) {
    return _then(_self.copyWith(teamId: value));
  });
}
}


/// Adds pattern-matching-related methods to [MessagePath].
extension MessagePathPatterns on MessagePath {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagePath value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagePath value)  $default,){
final _that = this;
switch (_that) {
case _MessagePath():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagePath value)?  $default,){
final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MessageId messageId,  TeamId teamId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
return $default(_that.messageId,_that.teamId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MessageId messageId,  TeamId teamId)  $default,) {final _that = this;
switch (_that) {
case _MessagePath():
return $default(_that.messageId,_that.teamId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MessageId messageId,  TeamId teamId)?  $default,) {final _that = this;
switch (_that) {
case _MessagePath() when $default != null:
return $default(_that.messageId,_that.teamId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagePath implements MessagePath {
  const _MessagePath({required this.messageId, required this.teamId});
  factory _MessagePath.fromJson(Map<String, dynamic> json) => _$MessagePathFromJson(json);

@override final  MessageId messageId;
@override final  TeamId teamId;

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagePathCopyWith<_MessagePath> get copyWith => __$MessagePathCopyWithImpl<_MessagePath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagePathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagePath&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.teamId, teamId) || other.teamId == teamId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,messageId,teamId);

@override
String toString() {
  return 'MessagePath(messageId: $messageId, teamId: $teamId)';
}


}

/// @nodoc
abstract mixin class _$MessagePathCopyWith<$Res> implements $MessagePathCopyWith<$Res> {
  factory _$MessagePathCopyWith(_MessagePath value, $Res Function(_MessagePath) _then) = __$MessagePathCopyWithImpl;
@override @useResult
$Res call({
 MessageId messageId, TeamId teamId
});


@override $MessageIdCopyWith<$Res> get messageId;@override $TeamIdCopyWith<$Res> get teamId;

}
/// @nodoc
class __$MessagePathCopyWithImpl<$Res>
    implements _$MessagePathCopyWith<$Res> {
  __$MessagePathCopyWithImpl(this._self, this._then);

  final _MessagePath _self;
  final $Res Function(_MessagePath) _then;

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messageId = null,Object? teamId = null,}) {
  return _then(_MessagePath(
messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as MessageId,teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as TeamId,
  ));
}

/// Create a copy of MessagePath
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MessageIdCopyWith<$Res> get messageId {
  
  return $MessageIdCopyWith<$Res>(_self.messageId, (value) {
    return _then(_self.copyWith(messageId: value));
  });
}/// Create a copy of MessagePath
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
