import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/item.dart';
import 'package:example/firestore/models/message.dart';
import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/models/team.dart';
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

  Stream<Team?> teamStream({required TeamId teamId}) {
    return _firestoreReferenceService
        .teamReference(teamId: teamId)
        .snapshots()
        .map(
          (event) => event.data(),
        );
  }

  Stream<List<User>> usersCollectionStream({required TeamId teamId}) {
    return _firestoreReferenceService
        .usersCollection(teamId: teamId)
        .snapshots()
        .map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<User>> usersCollectionWhereStream({
    required TeamId teamId,
    required Query<User> Function(CollectionReference<User>) where,
  }) {
    final collection =
        _firestoreReferenceService.usersCollection(teamId: teamId);
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<User?> userStream({
    required UserId userId,
    required TeamId teamId,
  }) {
    return _firestoreReferenceService
        .userReference(
          userId: userId,
          teamId: teamId,
        )
        .snapshots()
        .map(
          (event) => event.data(),
        );
  }

  Stream<List<Item>> itemsCollectionStream({
    required UserId userId,
    required TeamId teamId,
  }) {
    return _firestoreReferenceService
        .itemsCollection(
          userId: userId,
          teamId: teamId,
        )
        .snapshots()
        .map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<Item>> itemsCollectionWhereStream({
    required UserId userId,
    required TeamId teamId,
    required Query<Item> Function(CollectionReference<Item>) where,
  }) {
    final collection = _firestoreReferenceService.itemsCollection(
      userId: userId,
      teamId: teamId,
    );
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<Item?> itemStream({
    required ItemId itemId,
    required TeamId teamId,
    required UserId userId,
  }) {
    return _firestoreReferenceService
        .itemReference(
          itemId: itemId,
          teamId: teamId,
          userId: userId,
        )
        .snapshots()
        .map(
          (event) => event.data(),
        );
  }

  Stream<List<Message>> messagesCollectionStream({required TeamId teamId}) {
    return _firestoreReferenceService
        .messagesCollection(teamId: teamId)
        .snapshots()
        .map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<List<Message>> messagesCollectionWhereStream({
    required TeamId teamId,
    required Query<Message> Function(CollectionReference<Message>) where,
  }) {
    final collection =
        _firestoreReferenceService.messagesCollection(teamId: teamId);
    return where(collection).snapshots().map(
          (event) => event.docs.map((snapshot) => snapshot.data()).toList(),
        );
  }

  Stream<Message?> messageStream({
    required MessageId messageId,
    required TeamId teamId,
  }) {
    return _firestoreReferenceService
        .messageReference(
          messageId: messageId,
          teamId: teamId,
        )
        .snapshots()
        .map(
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

  Stream<Task?> taskStream({required TaskId taskId}) {
    return _firestoreReferenceService
        .taskReference(taskId: taskId)
        .snapshots()
        .map(
          (event) => event.data(),
        );
  }
}
