import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages.freezed.dart';
part 'messages.g.dart';

extension type const MessageId(String value) {}

@Freezed(
  toJson: true,
  fromJson: true,
)
class Message with _$Message {
  const factory Message({
    @JsonKey(name: Message.contentFieldKey) required String content,
    @JsonKey(name: Message.dateFieldKey) required DateTime date,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static const String contentFieldKey = 'content';

  static const String dateFieldKey = 'date';
}
