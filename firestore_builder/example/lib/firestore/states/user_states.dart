import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose.family<User?, UserId>((
  ref,
  id,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.userStream(id);
});
final userProvider = Provider.autoDispose.family<User?, UserId>((
  ref,
  id,
) {
  final stream = ref.watch(userStreamProvider(id));
  return stream.value;
});
final userCollectionStreamProvider =
    StreamProvider.autoDispose<List<User>>((ref) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.usersCollectionStream();
});
final userCollectionProvider = Provider.autoDispose<List<User>?>((ref) {
  final stream = ref.watch(userCollectionStreamProvider);
  return stream.value;
});
