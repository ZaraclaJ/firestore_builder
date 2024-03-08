import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreReferenceService {
  const FirestoreReferenceService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;
}
