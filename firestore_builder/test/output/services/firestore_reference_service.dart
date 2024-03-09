import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_builder/test/output/models/message.dart';
import 'package:firestore_builder/test/output/models/user.dart';
import 'package:firestore_builder/test/output/services/firestore_reference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider.autoDispose<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
final firestoreReferenceServiceProvider =
    Provider.autoDispose<FirestoreReferenceService>((ref) {
  return FirestoreReferenceService(firestore: ref.watch(firestoreProvider));
});

class FirestoreReferenceService {
  const FirestoreReferenceService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<User> usersCollection() {
    return _firestore.collection(User.collectionKey).withConverter(
          fromFirestore: User.fromFirestore,
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
          fromFirestore: Message.fromFirestore,
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
}
