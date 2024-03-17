import 'package:firestore_builder/test/output/models/item.dart';
import 'package:firestore_builder/test/output/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemStreamProvider = StreamProvider.autoDispose.family<Item?, ItemId>(
  (
    ref,
    id,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.itemStream(id);
  },
);
final itemProvider = Provider.autoDispose.family<Item?, ItemId>(
  (
    ref,
    id,
  ) {
    final stream = ref.watch(itemStreamProvider(id));
    return stream.value;
  },
);
final itemCollectionStreamProvider = StreamProvider.autoDispose<List<Item>>(
  (ref) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.itemsCollectionStream();
  },
);
final itemCollectionProvider = Provider.autoDispose<List<Item>?>(
  (ref) {
    final stream = ref.watch(itemCollectionStreamProvider);
    return stream.value;
  },
);
