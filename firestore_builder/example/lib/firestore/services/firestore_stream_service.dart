import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/models/team.dart';
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
