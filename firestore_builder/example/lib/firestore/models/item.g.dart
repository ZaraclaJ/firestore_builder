// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

_$ItemIdImpl _$$ItemIdImplFromJson(Map<String, dynamic> json) => _$ItemIdImpl(
      json['value'] as String,
    );

Map<String, dynamic> _$$ItemIdImplToJson(_$ItemIdImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

_$ItemPathImpl _$$ItemPathImplFromJson(Map<String, dynamic> json) =>
    _$ItemPathImpl(
      itemId: ItemId.fromJson(json['itemId'] as Map<String, dynamic>),
      teamId: TeamId.fromJson(json['teamId'] as Map<String, dynamic>),
      userId: UserId.fromJson(json['userId'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ItemPathImplToJson(_$ItemPathImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'teamId': instance.teamId,
      'userId': instance.userId,
    };
