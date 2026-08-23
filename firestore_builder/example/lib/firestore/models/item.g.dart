// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Item _$ItemFromJson(Map<String, dynamic> json) =>
    _Item(name: json['name'] as String);

Map<String, dynamic> _$ItemToJson(_Item instance) => <String, dynamic>{
  'name': instance.name,
};

_ItemId _$ItemIdFromJson(Map<String, dynamic> json) =>
    _ItemId(json['value'] as String);

Map<String, dynamic> _$ItemIdToJson(_ItemId instance) => <String, dynamic>{
  'value': instance.value,
};

_ItemPath _$ItemPathFromJson(Map<String, dynamic> json) => _ItemPath(
  itemId: ItemId.fromJson(json['itemId'] as Map<String, dynamic>),
  teamId: TeamId.fromJson(json['teamId'] as Map<String, dynamic>),
  userId: UserId.fromJson(json['userId'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ItemPathToJson(_ItemPath instance) => <String, dynamic>{
  'itemId': instance.itemId,
  'teamId': instance.teamId,
  'userId': instance.userId,
};
