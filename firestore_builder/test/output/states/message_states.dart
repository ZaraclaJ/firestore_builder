import 'package:firestore_builder/test/output/models/message.dart';
import 'package:firestore_builder/test/output/services/firestore_stream_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageStreamProvider =
    StreamProvider.autoDispose.family<Message?, MessageId>((
  ref,
  id,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.messageStream(id);
});
