import 'package:firestore_builder/test/output/models/user.dart';
import 'package:firestore_builder/test/output/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose.family<User?, UserId>((
  ref,
  id,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.userStream(id);
});
