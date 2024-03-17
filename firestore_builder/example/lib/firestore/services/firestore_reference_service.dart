import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/message.dart';
import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider.autoDispose<FirebaseFirestore>(
  (ref) {
    return FirebaseFirestore.instance;
  },
);
final firestoreReferenceServiceProvider =
    Provider.autoDispose<FirestoreReferenceService>(
  (ref) {
    return FirestoreReferenceService(firestore: ref.watch(firestoreProvider));
  },
);

class FirestoreReferenceService {
  const FirestoreReferenceService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Team> teamsCollection() {
    return _firestore.collection(Team.collectionKey).withConverter(
      fromFirestore: (
        snapshot,
        _,
      ) {
        return Team.fromFirestore(snapshot);
      },
      toFirestore: (
        value,
        _,
      ) {
        return value.toFirestore();
      },
    );
  }

  DocumentReference<Team> teamReference({required TeamId teamId}) {
    return teamsCollection().doc(teamId.value);
  }

  CollectionReference<User> usersCollection({required TeamId teamId}) {
    return teamReference(teamId: teamId)
        .collection(User.collectionKey)
        .withConverter(
      fromFirestore: (
        snapshot,
        _,
      ) {
        return User.fromFirestore(snapshot);
      },
      toFirestore: (
        value,
        _,
      ) {
        return value.toFirestore();
      },
    );
  }

  DocumentReference<User> userReference({
    required UserId userId,
    required TeamId teamId,
  }) {
    return usersCollection(teamId: teamId).doc(userId.value);
  }

  CollectionReference<Message> messagesCollection({required TeamId teamId}) {
    return teamReference(teamId: teamId)
        .collection(Message.collectionKey)
        .withConverter(
      fromFirestore: (
        snapshot,
        _,
      ) {
        return Message.fromFirestore(snapshot);
      },
      toFirestore: (
        value,
        _,
      ) {
        return value.toFirestore();
      },
    );
  }

  DocumentReference<Message> messageReference({
    required MessageId messageId,
    required TeamId teamId,
  }) {
    return messagesCollection(teamId: teamId).doc(messageId.value);
  }

  CollectionReference<Task> tasksCollection() {
    return _firestore.collection(Task.collectionKey).withConverter(
      fromFirestore: (
        snapshot,
        _,
      ) {
        return Task.fromFirestore(snapshot);
      },
      toFirestore: (
        value,
        _,
      ) {
        return value.toFirestore();
      },
    );
  }

  DocumentReference<Task> taskReference({required TaskId taskId}) {
    return tasksCollection().doc(taskId.value);
  }
}
