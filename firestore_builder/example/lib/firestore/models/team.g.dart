// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      name: json['name'] as String,
      userCount: json['user_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'user_count': instance.userCount,
      'created_at': instance.createdAt.toIso8601String(),
      'description': instance.description,
    };

_$TeamIdImpl _$$TeamIdImplFromJson(Map<String, dynamic> json) => _$TeamIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$TeamIdImplToJson(_$TeamIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
