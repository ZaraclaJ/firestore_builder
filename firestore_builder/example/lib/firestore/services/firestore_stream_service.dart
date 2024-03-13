import 'dart:async';

import 'package:example/firestore/models/message.dart';
import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_reference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreStreamServiceProvider =
    Provider.autoDispose<FirestoreStreamService>(
  (ref) {
    return FirestoreStreamService(
      firestoreReferenceService: ref.watch(firestoreReferenceServiceProvider),
    );
  },
);

class FirestoreStreamService {
  const FirestoreStreamService({
    required FirestoreReferenceService firestoreReferenceService,
  }) : _firestoreReferenceService = firestoreReferenceService;

  final FirestoreReferenceService _firestoreReferenceService;

  Stream<User?> userStream(UserId id) {
    return _firestoreReferenceService.userReference(id).snapshots().map(
          (event) => event.data(),
        );
  }

  Stream<List<User>> usersCollectionStream() {
    return _firestoreReferenceService.usersCollection().snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<Message?> messageStream(MessageId id) {
    return _firestoreReferenceService.messageReference(id).snapshots().map(
          (event) => event.data(),
        );
  }

  Stream<List<Message>> messagesCollectionStream() {
    return _firestoreReferenceService.messagesCollection().snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }
}
