import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';
part 'users.g.dart';

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
    @Default('')
    String firestoreId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  const User._();

  static const String nameFieldKey = 'name';

  static const String currentJobFieldKey = 'current_job';

  static const String ageFieldKey = 'age';

  UserId get userId => UserId(firestoreId);
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class UserId with _$UserId {
  const factory UserId(String value) = _UserId;

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);
}
