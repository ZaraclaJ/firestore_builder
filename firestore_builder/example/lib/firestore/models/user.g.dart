// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      age: json['age'] as int,
      currentJob: json['current_job'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'current_job': instance.currentJob,
    };

_$UserIdImpl _$$UserIdImplFromJson(Map<String, dynamic> json) => _$UserIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$UserIdImplToJson(_$UserIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$UserPathImpl _$$UserPathImplFromJson(Map<String, dynamic> json) =>
    _$UserPathImpl(
      userId: UserId.fromJson(json['userId'] as Map<String, dynamic>),
      teamId: TeamId.fromJson(json['teamId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserPathImplToJson(_$UserPathImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'teamId': instance.teamId,
    };
