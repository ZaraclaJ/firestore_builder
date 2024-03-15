import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskStreamProvider = StreamProvider.autoDispose.family<Task?, TaskId>(
  (
    ref,
    id,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.taskStream(id);
  },
);
final taskProvider = Provider.autoDispose.family<Task?, TaskId>(
  (
    ref,
    id,
  ) {
    final stream = ref.watch(taskStreamProvider(id));
    return stream.value;
  },
);
final taskCollectionStreamProvider = StreamProvider.autoDispose<List<Task>>(
  (ref) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.tasksCollectionStream();
  },
);
final taskCollectionProvider = Provider.autoDispose<List<Task>?>(
  (ref) {
    final stream = ref.watch(taskCollectionStreamProvider);
    return stream.value;
  },
);
