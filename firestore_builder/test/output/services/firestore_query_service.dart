import 'package:firestore_builder/test/output/models/message.dart';
import 'package:firestore_builder/test/output/models/user.dart';
import 'package:firestore_builder/test/output/services/firestore_reference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreQueryServiceProvider =
    Provider.autoDispose<FirestoreQueryService>(
  (ref) {
    return FirestoreQueryService(
      firestoreReferenceService: ref.watch(firestoreReferenceServiceProvider),
    );
  },
);

class FirestoreQueryService {
  const FirestoreQueryService({
    required FirestoreReferenceService firestoreReferenceService,
  }) : _firestoreReferenceService = firestoreReferenceService;

  final FirestoreReferenceService _firestoreReferenceService;

  Future<String> addUser(User user) async {
    final result = await _firestoreReferenceService.usersCollection().add(user);
    return result.id;
  }

  Future<User?> getUser(UserId userId) async {
    final result = await _firestoreReferenceService.userReference(userId).get();
    return result.data();
  }

  Future<void> updateUser({
    required UserId userId,
    UpdatedValue<String>? name,
    UpdatedValue<String?>? currentJob,
    UpdatedValue<int>? age,
  }) async {
    final data = {
      if (name != null) User.nameFieldKey: name.value,
      if (currentJob != null) User.currentJobFieldKey: currentJob.value,
      if (age != null) User.ageFieldKey: age.value,
    };
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService.userReference(userId).update(data);
  }

  Future<void> deleteUser(UserId userId) async {
    await _firestoreReferenceService.userReference(userId).delete();
  }

  Future<String> addMessage(Message message) async {
    final result =
        await _firestoreReferenceService.messagesCollection().add(message);
    return result.id;
  }

  Future<Message?> getMessage(MessageId messageId) async {
    final result =
        await _firestoreReferenceService.messageReference(messageId).get();
    return result.data();
  }

  Future<void> updateMessage({
    required MessageId messageId,
    UpdatedValue<String>? content,
    UpdatedValue<DateTime>? date,
  }) async {
    final data = {
      if (content != null) Message.contentFieldKey: content.value,
      if (date != null) Message.dateFieldKey: date.value,
    };
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService.messageReference(messageId).update(data);
  }

  Future<void> deleteMessage(MessageId messageId) async {
    await _firestoreReferenceService.messageReference(messageId).delete();
  }
}

class UpdatedValue<T> {
  const UpdatedValue(
    this.value,
  );

  final T value;
}
