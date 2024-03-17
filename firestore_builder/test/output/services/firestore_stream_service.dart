import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_builder/test/output/models/message.dart';
import 'package:firestore_builder/test/output/models/task.dart';
import 'package:firestore_builder/test/output/models/team.dart';
import 'package:firestore_builder/test/output/models/user.dart';
import 'package:firestore_builder/test/output/services/firestore_reference_service.dart';
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

  Stream<List<Team>> teamsCollectionStream() {
    return _firestoreReferenceService.teamsCollection().snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<Team>> teamsCollectionWhereStream(
      {required Query<Team> Function(CollectionReference<Team>) where}) {
    final collection = _firestoreReferenceService.teamsCollection();
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<Team?> teamStream(TeamId id) {
    return _firestoreReferenceService.teamReference(id).snapshots().map(
          (event) => event.data(),
        );
  }

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

  Stream<List<Task>> tasksCollectionStream() {
    return _firestoreReferenceService.tasksCollection().snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<Task>> tasksCollectionWhereStream(
      {required Query<Task> Function(CollectionReference<Task>) where}) {
    final collection = _firestoreReferenceService.tasksCollection();
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<Task?> taskStream(TaskId id) {
    return _firestoreReferenceService.taskReference(id).snapshots().map(
          (event) => event.data(),
        );
  }
}
