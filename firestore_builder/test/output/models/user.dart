import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
)
class User with _$User {
  const factory User({
    @JsonKey(name: User.nameFieldKey) required String name,
    @JsonKey(name: User.ageFieldKey) required int age,
    @JsonKey(name: User.currentJobFieldKey) String? currentJob,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(UserId(''))
    UserId userId,
  }) = _User;

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
  ) {
    final data = snapshot.data();
    return User.fromJson(data!).copyWith(userId: UserId(snapshot.id));
  }

  factory User.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserFromJson(json);

  const User._();

  static const String collectionKey = 'users';

  static const String nameFieldKey = 'name';

  static const String currentJobFieldKey = 'current_job';

  static const String ageFieldKey = 'age';

  Map<String, Object?> toFirestore() {
    final json = toJson();
    return json;
  }
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class UserId with _$UserId {
  const factory UserId(
    String value,
  ) = _UserId;

  factory UserId.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$UserIdFromJson(json);
}
