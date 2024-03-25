// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      content: json['content'] as String,
      date: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['date'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'date': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.date, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$MessageIdImpl _$$MessageIdImplFromJson(Map<String, dynamic> json) =>
    _$MessageIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$MessageIdImplToJson(_$MessageIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$MessagePathImpl _$$MessagePathImplFromJson(Map<String, dynamic> json) =>
    _$MessagePathImpl(
      messageId: MessageId.fromJson(json['messageId'] as Map<String, dynamic>),
      teamId: TeamId.fromJson(json['teamId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MessagePathImplToJson(_$MessagePathImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'teamId': instance.teamId,
    };
