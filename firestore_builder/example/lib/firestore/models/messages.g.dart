// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'date': instance.date.toIso8601String(),
    };

_$MessageIdImpl _$$MessageIdImplFromJson(Map<String, dynamic> json) =>
    _$MessageIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$MessageIdImplToJson(_$MessageIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
