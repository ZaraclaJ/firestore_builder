import 'package:example/firestore/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose.family<User?, UserId>((
  ref,
  id,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.userStream(id);
});
