import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/converters/freezed_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
)
class Team with _$Team {
  const factory Team({
    @JsonKey(name: Team.nameFieldKey) required String name,
    @JsonKey(name: Team.userCountFieldKey) required int userCount,
    @DateTimeConverter()
    @JsonKey(name: Team.createdAtFieldKey)
    required DateTime createdAt,
    @JsonKey(name: Team.labelsFieldKey) required List<String> labels,
    @JsonKey(name: Team.descriptionFieldKey) String? description,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    FieldValue? createdAtFieldValue,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    FieldValue? labelsFieldValue,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(TeamId(''))
    TeamId teamId,
  }) = _Team;

  factory Team.fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
  ) {
    final data = snapshot.data();
    return Team.fromJson(data!).copyWith(teamId: TeamId(snapshot.id));
  }

  factory Team.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TeamFromJson(json);

  const Team._();

  static const String collectionKey = 'teams';

  static const String nameFieldKey = 'name';

  static const String descriptionFieldKey = 'description';

  static const String userCountFieldKey = 'user_count';

  static const String createdAtFieldKey = 'created_at';

  static const String labelsFieldKey = 'labels';

  Map<String, Object?> toFirestore() {
    final json = toJson();
    if (createdAtFieldValue != null) {
      json[createdAtFieldKey] = createdAtFieldValue;
    }
    if (labelsFieldValue != null) {
      json[labelsFieldKey] = labelsFieldValue;
    }
    return json;
  }
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class TeamId with _$TeamId {
  const factory TeamId(
    String value,
  ) = _TeamId;

  factory TeamId.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TeamIdFromJson(json);
}
