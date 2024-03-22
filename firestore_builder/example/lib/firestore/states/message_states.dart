import 'package:example/firestore/models/message.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageStreamProvider =
    StreamProvider.autoDispose.family<Message?, MessagePath>(
  (
    ref,
    messagePath,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.messageStream(
      messageId: messagePath.messageId,
      teamId: messagePath.teamId,
    );
  },
);
final messageProvider = Provider.autoDispose.family<Message?, MessagePath>(
  (
    ref,
    messagePath,
  ) {
    final stream = ref.watch(messageStreamProvider(messagePath));
    return stream.value;
  },
);
final messageCollectionStreamProvider =
    StreamProvider.autoDispose.family<List<Message>, TeamId>(
  (
    ref,
    teamId,
  ) {
    final service = ref.watch(firestoreStreamServiceProvider);
    return service.messagesCollectionStream(teamId: teamId);
  },
);
final messageCollectionProvider =
    Provider.autoDispose.family<List<Message>?, TeamId>(
  (
    ref,
    teamId,
  ) {
    final stream = ref.watch(messageCollectionStreamProvider(teamId));
    return stream.value;
  },
);
