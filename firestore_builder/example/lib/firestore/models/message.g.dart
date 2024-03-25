// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      content: json['content'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'date': instance.date?.toIso8601String(),
    };

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
