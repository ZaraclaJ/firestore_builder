import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
)
class Task with _$Task {
  const factory Task({
    @JsonKey(name: Task.nameFieldKey) required String name,
    @JsonKey(name: Task.doneFieldKey) required bool done,
    @JsonKey(name: Task.descriptionFieldKey) String? description,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(TaskId(''))
    TaskId taskId,
  }) = _Task;

  factory Task.fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
  ) {
    final data = snapshot.data();
    return Task.fromJson(data!).copyWith(taskId: TaskId(snapshot.id));
  }

  factory Task.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TaskFromJson(json);

  const Task._();

  static const String collectionKey = 'tasks';

  static const String nameFieldKey = 'name';

  static const String descriptionFieldKey = 'description';

  static const String doneFieldKey = 'done';

  Map<String, Object?> toFirestore() {
    final json = toJson();
    return json;
  }
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class TaskId with _$TaskId {
  const factory TaskId(
    String value,
  ) = _TaskId;

  factory TaskId.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TaskIdFromJson(json);
}
