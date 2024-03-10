import 'package:example/firestore/models/message.dart';
import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_reference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreQueryServiceProvider =
    Provider.autoDispose<FirestoreQueryService>((ref) {
  return FirestoreQueryService(
      firestoreReferenceService: ref.watch(firestoreReferenceServiceProvider));
});

class FirestoreQueryService {
  const FirestoreQueryService(
      {required FirestoreReferenceService firestoreReferenceService})
      : _firestoreReferenceService = firestoreReferenceService;

  final FirestoreReferenceService _firestoreReferenceService;

  Future<String> addUser(User user) async {
    final result = await _firestoreReferenceService.usersCollection().add(user);
    return result.id;
  }

  Future<String> addMessage(Message message) async {
    final result =
        await _firestoreReferenceService.messagesCollection().add(message);
    return result.id;
  }
}
