import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_builder/models/enums/team_size.dart';
import 'package:firestore_builder/test/output/converters/freezed_converters.dart';
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
    @JsonKey(name: Team.teamSizeFieldKey) required TeamSize teamSize,
    @JsonKey(name: Team.descriptionFieldKey) String? description,
    @TimestampConverter()
    @JsonKey(name: Team.datesFieldKey)
    List<Timestamp?>? dates,
    @JsonKey(name: Team.bytesFieldKey) List<List<int>>? bytes,
    @JsonKey(name: Team.presencesFieldKey) Map<String, bool>? presences,
    @DocumentReferenceConverter()
    @JsonKey(name: Team.teamRefFieldKey)
    DocumentReference? teamRef,
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

  static const String datesFieldKey = 'dates';

  static const String bytesFieldKey = 'bytes';

  static const String labelsFieldKey = 'labels';

  static const String presencesFieldKey = 'presences';

  static const String teamRefFieldKey = 'team_ref';

  static const String teamSizeFieldKey = 'team_size';

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
