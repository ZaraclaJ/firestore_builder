import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_builder/test/output/models/messages.dart';
import 'package:firestore_builder/test/output/models/users.dart';

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
