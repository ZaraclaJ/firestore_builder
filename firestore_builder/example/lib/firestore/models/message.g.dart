// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  content: json['content'] as String,
  date: _$JsonConverterFromJson<Timestamp, Timestamp>(
    json['date'],
    const TimestampConverter().fromJson,
  ),
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'content': instance.content,
  'date': _$JsonConverterToJson<Timestamp, Timestamp>(
    instance.date,
    const TimestampConverter().toJson,
  ),
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_MessageId _$MessageIdFromJson(Map<String, dynamic> json) =>
    _MessageId(json['value'] as String);

Map<String, dynamic> _$MessageIdToJson(_MessageId instance) =>
    <String, dynamic>{'value': instance.value};

_MessagePath _$MessagePathFromJson(Map<String, dynamic> json) => _MessagePath(
  messageId: MessageId.fromJson(json['messageId'] as Map<String, dynamic>),
  teamId: TeamId.fromJson(json['teamId'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MessagePathToJson(_MessagePath instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'teamId': instance.teamId,
    };
