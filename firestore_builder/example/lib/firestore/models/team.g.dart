// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      name: json['name'] as String,
      userCount: json['user_count'] as int,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as Timestamp),
      labels:
          (json['labels'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String?,
      presences: (json['presences'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'user_count': instance.userCount,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'labels': instance.labels,
      'description': instance.description,
      'presences': instance.presences,
    };

_$TeamIdImpl _$$TeamIdImplFromJson(Map<String, dynamic> json) => _$TeamIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$TeamIdImplToJson(_$TeamIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
