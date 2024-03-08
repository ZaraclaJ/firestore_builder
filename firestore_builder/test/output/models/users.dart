import 'package:freezed_annotation/freezed_annotation.dart';

part 'users.freezed.dart';
part 'users.g.dart';

extension type const UserId(String value) {}

@Freezed(
  toJson: true,
  fromJson: true,
)
class User with _$User {
  const factory User({
    @JsonKey(name: User.nameFieldKey) required String name,
    @JsonKey(name: User.currentJobFieldKey) required String? currentJob,
    @JsonKey(name: User.ageFieldKey) required int age,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static const String nameFieldKey = 'name';

  static const String currentJobFieldKey = 'current_job';

  static const String ageFieldKey = 'age';
}
