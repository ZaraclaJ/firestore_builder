// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  currentJob: json['current_job'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'name': instance.name,
  'age': instance.age,
  'current_job': instance.currentJob,
};

_UserId _$UserIdFromJson(Map<String, dynamic> json) =>
    _UserId(json['value'] as String);

Map<String, dynamic> _$UserIdToJson(_UserId instance) => <String, dynamic>{
  'value': instance.value,
};

_UserPath _$UserPathFromJson(Map<String, dynamic> json) => _UserPath(
  userId: UserId.fromJson(json['userId'] as Map<String, dynamic>),
  teamId: TeamId.fromJson(json['teamId'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserPathToJson(_UserPath instance) => <String, dynamic>{
  'userId': instance.userId,
  'teamId': instance.teamId,
};
