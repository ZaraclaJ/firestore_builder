import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/team.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
)
class Message with _$Message {
  const factory Message({
    @JsonKey(name: Message.contentFieldKey) required String content,
    @JsonKey(name: Message.dateFieldKey) DateTime? date,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(MessageId(''))
    MessageId messageId,
  }) = _Message;

  factory Message.fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
  ) {
    final data = snapshot.data();
    return Message.fromJson(data!).copyWith(messageId: MessageId(snapshot.id));
  }

  factory Message.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MessageFromJson(json);

  const Message._();

  static const String collectionKey = 'messages';

  static const String contentFieldKey = 'content';

  static const String dateFieldKey = 'date';

  Map<String, Object?> toFirestore() {
    final json = toJson();
    return json;
  }
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class MessageId with _$MessageId {
  const factory MessageId(
    String value,
  ) = _MessageId;

  factory MessageId.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MessageIdFromJson(json);
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class MessagePath with _$MessagePath {
  const factory MessagePath({
    required MessageId messageId,
    required TeamId teamId,
  }) = _MessagePath;

  factory MessagePath.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$MessagePathFromJson(json);
}
