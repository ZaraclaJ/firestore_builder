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
      teamSize: $enumDecode(_$TeamSizeEnumMap, json['team_size']),
      description: json['description'] as String?,
      dates: (json['dates'] as List<dynamic>?)
          ?.map((e) => _$JsonConverterFromJson<Timestamp, Timestamp>(
              e, const TimestampConverter().fromJson))
          .toList(),
      bytes: (json['bytes'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      presences: (json['presences'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
      teamRef: _$JsonConverterFromJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          json['team_ref'], const DocumentReferenceConverter().fromJson),
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'user_count': instance.userCount,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'labels': instance.labels,
      'team_size': _$TeamSizeEnumMap[instance.teamSize]!,
      'description': instance.description,
      'dates': instance.dates
          ?.map((e) => _$JsonConverterToJson<Timestamp, Timestamp>(
              e, const TimestampConverter().toJson))
          .toList(),
      'bytes': instance.bytes,
      'presences': instance.presences,
      'team_ref': _$JsonConverterToJson<DocumentReference<Object?>,
              DocumentReference<Object?>>(
          instance.teamRef, const DocumentReferenceConverter().toJson),
    };

const _$TeamSizeEnumMap = {
  TeamSize.solo: 'solo',
  TeamSize.duo: 'duo',
  TeamSize.small: 'small',
  TeamSize.medium: 'medium',
  TeamSize.large: 'large',
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

_$TeamIdImpl _$$TeamIdImplFromJson(Map<String, dynamic> json) => _$TeamIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$TeamIdImplToJson(_$TeamIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
