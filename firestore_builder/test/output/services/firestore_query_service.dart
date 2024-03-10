import 'package:firestore_builder/test/output/models/message.dart';
import 'package:firestore_builder/test/output/models/user.dart';
import 'package:firestore_builder/test/output/services/firestore_reference_service.dart';
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

  Future<void> deleteUser(UserId userId) async {
    await _firestoreReferenceService.userReference(userId).delete();
  }

  Future<String> addMessage(Message message) async {
    final result =
        await _firestoreReferenceService.messagesCollection().add(message);
    return result.id;
  }

  Future<void> deleteMessage(MessageId messageId) async {
    await _firestoreReferenceService.messageReference(messageId).delete();
  }
}
