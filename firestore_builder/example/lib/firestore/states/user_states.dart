import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStreamProvider = StreamProvider.autoDispose.family<User?, UserPath>(
  (
    ref,
    userPath,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.userStream(
      userId: userPath.userId,
      teamId: userPath.teamId,
    );
  },
);
final userProvider = Provider.autoDispose.family<User?, UserPath>(
  (
    ref,
    userPath,
  ) {
    final stream = ref.watch(userStreamProvider(userPath));
    return stream.value;
  },
);
final userCollectionStreamProvider =
    StreamProvider.autoDispose.family<List<User>, TeamId>(
  (
    ref,
    teamId,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.usersCollectionStream(teamId: teamId);
  },
);
final userCollectionProvider = Provider.autoDispose.family<List<User>?, TeamId>(
  (
    ref,
    teamId,
  ) {
    final stream = ref.watch(userCollectionStreamProvider(teamId));
    return stream.value;
  },
);
