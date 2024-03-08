import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages.freezed.dart';
part 'messages.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
)
class Message with _$Message {
  const factory Message({
    @JsonKey(name: Message.contentFieldKey) required String content,
    @JsonKey(name: Message.dateFieldKey) required DateTime date,
    @Default('') String firestoreId,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static const String contentFieldKey = 'content';

  static const String dateFieldKey = 'date';
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class MessageId with _$MessageId {
  const factory MessageId(String value) = _MessageId;

  factory MessageId.fromJson(Map<String, dynamic> json) =>
      _$MessageIdFromJson(json);
}
