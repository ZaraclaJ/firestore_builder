// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      name: json['name'] as String,
      done: json['done'] as bool,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'done': instance.done,
      'description': instance.description,
    };

_$TaskIdImpl _$$TaskIdImplFromJson(Map<String, dynamic> json) => _$TaskIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$TaskIdImplToJson(_$TaskIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
