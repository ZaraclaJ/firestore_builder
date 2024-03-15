import 'package:firestore_builder/test/output/models/team.dart';
import 'package:firestore_builder/test/output/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamStreamProvider = StreamProvider.autoDispose.family<Team?, TeamId>(
  (
    ref,
    id,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.teamStream(id);
  },
);
final teamProvider = Provider.autoDispose.family<Team?, TeamId>(
  (
    ref,
    id,
  ) {
    final stream = ref.watch(teamStreamProvider(id));
    return stream.value;
  },
);
final teamCollectionStreamProvider = StreamProvider.autoDispose<List<Team>>(
  (ref) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.teamsCollectionStream();
  },
);
final teamCollectionProvider = Provider.autoDispose<List<Team>?>(
  (ref) {
    final stream = ref.watch(teamCollectionStreamProvider);
    return stream.value;
  },
);
