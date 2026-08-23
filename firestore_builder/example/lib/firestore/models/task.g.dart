// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  name: json['name'] as String,
  done: json['done'] as bool,
  description: json['description'] as String?,
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'name': instance.name,
  'done': instance.done,
  'description': instance.description,
};

_TaskId _$TaskIdFromJson(Map<String, dynamic> json) =>
    _TaskId(json['value'] as String);

Map<String, dynamic> _$TaskIdToJson(_TaskId instance) => <String, dynamic>{
  'value': instance.value,
};
