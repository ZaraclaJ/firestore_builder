import 'package:firestore_builder/models/enums/team_size.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'updated_value.freezed.dart';
part 'updated_value.g.dart';

class UpdatedValue<T> {
  const UpdatedValue(this.value);

  final T value;
}

@Freezed(toJson: true, fromJson: true)
abstract class UpdatedValueTeamSize with _$UpdatedValueTeamSize {
  const factory UpdatedValueTeamSize(TeamSize teamSize) = _UpdatedValueTeamSize;

  factory UpdatedValueTeamSize.fromJson(Map<String, dynamic> json) =>
      _$UpdatedValueTeamSizeFromJson(json);

  const UpdatedValueTeamSize._();

  Object? get value => toJson()['teamSize'];
}

@Freezed(toJson: true, fromJson: true)
abstract class UpdatedValueTeamSizeList with _$UpdatedValueTeamSizeList {
  const factory UpdatedValueTeamSizeList(List<TeamSize>? teamSizeList) =
      _UpdatedValueTeamSizeList;

  factory UpdatedValueTeamSizeList.fromJson(Map<String, dynamic> json) =>
      _$UpdatedValueTeamSizeListFromJson(json);

  const UpdatedValueTeamSizeList._();

  Object? get value => toJson()['teamSizeList'];
}
