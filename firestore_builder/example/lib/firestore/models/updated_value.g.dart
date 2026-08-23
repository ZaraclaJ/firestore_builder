// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdatedValueTeamSize _$UpdatedValueTeamSizeFromJson(
  Map<String, dynamic> json,
) => _UpdatedValueTeamSize($enumDecode(_$TeamSizeEnumMap, json['teamSize']));

Map<String, dynamic> _$UpdatedValueTeamSizeToJson(
  _UpdatedValueTeamSize instance,
) => <String, dynamic>{'teamSize': _$TeamSizeEnumMap[instance.teamSize]!};

const _$TeamSizeEnumMap = {
  TeamSize.solo: 'solo',
  TeamSize.duo: 'duo',
  TeamSize.small: 'small',
  TeamSize.medium: 'medium',
  TeamSize.large: 'large',
};
