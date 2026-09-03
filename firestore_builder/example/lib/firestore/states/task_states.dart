import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskStreamProvider = StreamProvider.autoDispose.family<Task?, TaskId>((
  ref,
  taskId,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.taskStream(taskId: taskId);
}, dependencies: [firestoreStreamServiceProvider]);
final taskProvider = Provider.autoDispose.family<Task?, TaskId>((ref, taskId) {
  final stream = ref.watch(taskStreamProvider(taskId));
  return stream.value;
}, dependencies: [taskStreamProvider]);
final taskCollectionStreamProvider = StreamProvider.autoDispose<List<Task>>((
  ref,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.tasksCollectionStream();
}, dependencies: [firestoreStreamServiceProvider]);
final taskCollectionProvider = Provider.autoDispose<List<Task>?>((ref) {
  final stream = ref.watch(taskCollectionStreamProvider);
  return stream.value;
}, dependencies: [taskCollectionStreamProvider]);
