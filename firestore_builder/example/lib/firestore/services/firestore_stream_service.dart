import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<List<User>> usersCollectionStream() {
    return _firestoreReferenceService.usersCollection().snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<User>> usersCollectionWhereStream(
      {required Query<User> Function(CollectionReference<User>) where}) {
    final collection = _firestoreReferenceService.usersCollection();
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<User?> userStream(UserId id) {
    return _firestoreReferenceService.userReference(id).snapshots().map(
          (event) => event.data(),
        );
  }

  Stream<List<Message>> messagesCollectionStream() {
    return _firestoreReferenceService.messagesCollection().snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<Message>> messagesCollectionWhereStream(
      {required Query<Message> Function(CollectionReference<Message>) where}) {
    final collection = _firestoreReferenceService.messagesCollection();
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<Message?> messageStream(MessageId id) {
    return _firestoreReferenceService.messageReference(id).snapshots().map(
          (event) => event.data(),
        );
  }
}
