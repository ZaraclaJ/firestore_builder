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

  DocumentReference<Team> teamReference(TeamId id) {
    return teamsCollection().doc(id.value);
  }

  CollectionReference<User> usersCollection() {
    return _firestore.collection(User.collectionKey).withConverter(
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

  DocumentReference<User> userReference(UserId id) {
    return usersCollection().doc(id.value);
  }

  CollectionReference<Message> messagesCollection() {
    return _firestore.collection(Message.collectionKey).withConverter(
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

  DocumentReference<Message> messageReference(MessageId id) {
    return messagesCollection().doc(id.value);
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

  DocumentReference<Task> taskReference(TaskId id) {
    return tasksCollection().doc(id.value);
  }
}
