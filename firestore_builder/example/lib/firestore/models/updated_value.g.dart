// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdatedValueTeamSizeImpl _$$UpdatedValueTeamSizeImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatedValueTeamSizeImpl(
      $enumDecode(_$TeamSizeEnumMap, json['teamSize']),
    );

Map<String, dynamic> _$$UpdatedValueTeamSizeImplToJson(
        _$UpdatedValueTeamSizeImpl instance) =>
    <String, dynamic>{
      'teamSize': _$TeamSizeEnumMap[instance.teamSize]!,
    };

const _$TeamSizeEnumMap = {
  TeamSize.solo: 'solo',
  TeamSize.duo: 'duo',
  TeamSize.small: 'small',
  TeamSize.medium: 'medium',
  TeamSize.large: 'large',
};
