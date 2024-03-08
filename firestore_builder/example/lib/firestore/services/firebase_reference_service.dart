import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/messages.dart';
import 'package:example/firestore/models/users.dart';

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
}
