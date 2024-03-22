import 'package:firestore_builder/test/output/models/task.dart';
import 'package:firestore_builder/test/output/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskStreamProvider = StreamProvider.autoDispose.family<Task?, TaskId>(
  (
    ref,
    taskId,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.taskStream(taskId: taskId);
  },
);
final taskProvider = Provider.autoDispose.family<Task?, TaskId>(
  (
    ref,
    taskId,
  ) {
    final stream = ref.watch(taskStreamProvider(taskId));
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
