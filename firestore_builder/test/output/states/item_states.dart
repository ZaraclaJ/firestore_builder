import 'package:firestore_builder/test/output/models/item.dart';
import 'package:firestore_builder/test/output/models/user.dart';
import 'package:firestore_builder/test/output/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemStreamProvider = StreamProvider.autoDispose.family<Item?, ItemPath>(
  (
    ref,
    itemPath,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.itemStream(
      itemId: itemPath.itemId,
      teamId: itemPath.teamId,
      userId: itemPath.userId,
    );
  },
);
final itemProvider = Provider.autoDispose.family<Item?, ItemPath>(
  (
    ref,
    itemPath,
  ) {
    final stream = ref.watch(itemStreamProvider(itemPath));
    return stream.value;
  },
);
final itemCollectionStreamProvider =
    StreamProvider.autoDispose.family<List<Item>, UserPath>(
  (
    ref,
    userPath,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.itemsCollectionStream(
      userId: userPath.userId,
      teamId: userPath.teamId,
    );
  },
);
final itemCollectionProvider =
    Provider.autoDispose.family<List<Item>?, UserPath>(
  (
    ref,
    userPath,
  ) {
    final stream = ref.watch(itemCollectionStreamProvider(userPath));
    return stream.value;
  },
);
