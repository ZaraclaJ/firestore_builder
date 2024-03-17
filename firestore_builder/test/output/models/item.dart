import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_builder/test/output/models/team.dart';
import 'package:firestore_builder/test/output/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@Freezed(
  toJson: true,
  fromJson: true,
)
class Item with _$Item {
  const factory Item({
    @JsonKey(name: Item.nameFieldKey) required String name,
    @JsonKey(
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(ItemId(''))
    ItemId itemId,
  }) = _Item;

  factory Item.fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
  ) {
    final data = snapshot.data();
    return Item.fromJson(data!).copyWith(itemId: ItemId(snapshot.id));
  }

  factory Item.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ItemFromJson(json);

  const Item._();

  static const String collectionKey = 'items';

  static const String nameFieldKey = 'name';

  Map<String, Object?> toFirestore() {
    final json = toJson();
    return json;
  }
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class ItemId with _$ItemId {
  const factory ItemId(
    String value,
  ) = _ItemId;

  factory ItemId.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ItemIdFromJson(json);
}

@Freezed(
  toJson: true,
  fromJson: true,
)
class ItemPath with _$ItemPath {
  const factory ItemPath({
    required ItemId itemId,
    required TeamId teamId,
    required UserId userId,
  }) = _ItemPath;

  factory ItemPath.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ItemPathFromJson(json);
}
