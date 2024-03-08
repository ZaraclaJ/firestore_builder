import 'dart:async';

import 'package:firestore_builder/test/output/models/messages.dart';
import 'package:firestore_builder/test/output/models/users.dart';
import 'package:firestore_builder/test/output/services/firestore_reference_service.dart';

class FirestoreStreamService {
  const FirestoreStreamService(
      {required FirestoreReferenceService referenceService})
      : _referenceService = referenceService;

  final FirestoreReferenceService _referenceService;

  Stream<User?> userStream(UserId id) {
    return _referenceService
        .userReference(id)
        .snapshots()
        .map((event) => event.data());
  }

  Stream<List<User?>> usersCollectionStream() {
    return _referenceService
        .usersCollection()
        .snapshots()
        .map((event) => event.docs.map((snapshot) => snapshot.data()).toList());
  }

  Stream<Message?> messageStream(MessageId id) {
    return _referenceService
        .messageReference(id)
        .snapshots()
        .map((event) => event.data());
  }

  Stream<List<Message?>> messagesCollectionStream() {
    return _referenceService
        .messagesCollection()
        .snapshots()
        .map((event) => event.docs.map((snapshot) => snapshot.data()).toList());
  }
}
