import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/item.dart';
import 'package:example/firestore/models/message.dart';
import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_reference_service.dart';
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

  Future<List<Team>> getTeamsCollection() async {
    final result = await _firestoreReferenceService.teamsCollection().get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<List<Team>> getTeamsCollectionWhere(
      {required Query<Team> Function(CollectionReference<Team>) where}) async {
    final collection = _firestoreReferenceService.teamsCollection();
    final result = await where(collection).get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<Team?> getTeam({required TeamId teamId}) async {
    final result =
        await _firestoreReferenceService.teamReference(teamId: teamId).get();
    return result.data();
  }

  Future<String> addTeam({required Team team}) async {
    final result = await _firestoreReferenceService.teamsCollection().add(team);
    return result.id;
  }

  Future<void> setTeam({
    required TeamId teamId,
    required Team team,
  }) async {
    final teamId = team.teamId;
    assert(
      teamId.value.isNotEmpty,
      'team must have a teamId: $team',
    );
    await _firestoreReferenceService.teamReference(teamId: teamId).set(team);
  }

  Future<void> updateTeam({
    required TeamId teamId,
    UpdatedValue<String>? name,
    UpdatedValue<String?>? description,
    UpdatedValue<int>? userCount,
    UpdatedValue<DateTime>? createdAt,
    UpdatedValue<List<String>>? labels,
    UpdatedValue<Map<String, bool>?>? presences,
    UpdatedValue<FieldValue?>? createdAtFieldValue,
    UpdatedValue<FieldValue?>? labelsFieldValue,
  }) async {
    final data = {
      if (name != null) Team.nameFieldKey: name.value,
      if (description != null) Team.descriptionFieldKey: description.value,
      if (userCount != null) Team.userCountFieldKey: userCount.value,
      if (createdAt != null) Team.createdAtFieldKey: createdAt.value,
      if (labels != null) Team.labelsFieldKey: labels.value,
      if (presences != null) Team.presencesFieldKey: presences.value,
      if (createdAtFieldValue != null)
        Team.createdAtFieldKey: createdAtFieldValue.value,
      if (labelsFieldValue != null) Team.labelsFieldKey: labelsFieldValue.value,
    };
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService.teamReference(teamId: teamId).update(data);
  }

  Future<void> deleteTeam({required TeamId teamId}) async {
    await _firestoreReferenceService.teamReference(teamId: teamId).delete();
  }

  Future<List<User>> getUsersCollection({required TeamId teamId}) async {
    final result =
        await _firestoreReferenceService.usersCollection(teamId: teamId).get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<List<User>> getUsersCollectionWhere({
    required TeamId teamId,
    required Query<User> Function(CollectionReference<User>) where,
  }) async {
    final collection =
        _firestoreReferenceService.usersCollection(teamId: teamId);
    final result = await where(collection).get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<User?> getUser({
    required UserId userId,
    required TeamId teamId,
  }) async {
    final result = await _firestoreReferenceService
        .userReference(
          userId: userId,
          teamId: teamId,
        )
        .get();
    return result.data();
  }

  Future<String> addUser({
    required TeamId teamId,
    required User user,
  }) async {
    final result = await _firestoreReferenceService
        .usersCollection(teamId: teamId)
        .add(user);
    return result.id;
  }

  Future<void> setUser({
    required UserId userId,
    required TeamId teamId,
    required User user,
  }) async {
    final userId = user.userId;
    assert(
      userId.value.isNotEmpty,
      'user must have a userId: $user',
    );
    await _firestoreReferenceService
        .userReference(
          userId: userId,
          teamId: teamId,
        )
        .set(
          user,
        );
  }

  Future<void> updateUser({
    required UserId userId,
    required TeamId teamId,
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
    await _firestoreReferenceService
        .userReference(
          userId: userId,
          teamId: teamId,
        )
        .update(
          data,
        );
  }

  Future<void> deleteUser({
    required UserId userId,
    required TeamId teamId,
  }) async {
    await _firestoreReferenceService
        .userReference(
          userId: userId,
          teamId: teamId,
        )
        .delete();
  }

  Future<List<Item>> getItemsCollection({
    required UserId userId,
    required TeamId teamId,
  }) async {
    final result = await _firestoreReferenceService
        .itemsCollection(
          userId: userId,
          teamId: teamId,
        )
        .get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<List<Item>> getItemsCollectionWhere({
    required UserId userId,
    required TeamId teamId,
    required Query<Item> Function(CollectionReference<Item>) where,
  }) async {
    final collection = _firestoreReferenceService.itemsCollection(
      userId: userId,
      teamId: teamId,
    );
    final result = await where(collection).get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<Item?> getItem({
    required ItemId itemId,
    required TeamId teamId,
    required UserId userId,
  }) async {
    final result = await _firestoreReferenceService
        .itemReference(
          itemId: itemId,
          teamId: teamId,
          userId: userId,
        )
        .get();
    return result.data();
  }

  Future<String> addItem({
    required UserId userId,
    required TeamId teamId,
    required Item item,
  }) async {
    final result = await _firestoreReferenceService
        .itemsCollection(
          userId: userId,
          teamId: teamId,
        )
        .add(
          item,
        );
    return result.id;
  }

  Future<void> setItem({
    required ItemId itemId,
    required TeamId teamId,
    required UserId userId,
    required Item item,
  }) async {
    final itemId = item.itemId;
    assert(
      itemId.value.isNotEmpty,
      'item must have a itemId: $item',
    );
    await _firestoreReferenceService
        .itemReference(
          itemId: itemId,
          teamId: teamId,
          userId: userId,
        )
        .set(
          item,
        );
  }

  Future<void> updateItem({
    required ItemId itemId,
    required TeamId teamId,
    required UserId userId,
    UpdatedValue<String>? name,
  }) async {
    final data = {if (name != null) Item.nameFieldKey: name.value};
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService
        .itemReference(
          itemId: itemId,
          teamId: teamId,
          userId: userId,
        )
        .update(
          data,
        );
  }

  Future<void> deleteItem({
    required ItemId itemId,
    required TeamId teamId,
    required UserId userId,
  }) async {
    await _firestoreReferenceService
        .itemReference(
          itemId: itemId,
          teamId: teamId,
          userId: userId,
        )
        .delete();
  }

  Future<List<Message>> getMessagesCollection({required TeamId teamId}) async {
    final result = await _firestoreReferenceService
        .messagesCollection(teamId: teamId)
        .get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<List<Message>> getMessagesCollectionWhere({
    required TeamId teamId,
    required Query<Message> Function(CollectionReference<Message>) where,
  }) async {
    final collection =
        _firestoreReferenceService.messagesCollection(teamId: teamId);
    final result = await where(collection).get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<Message?> getMessage({
    required MessageId messageId,
    required TeamId teamId,
  }) async {
    final result = await _firestoreReferenceService
        .messageReference(
          messageId: messageId,
          teamId: teamId,
        )
        .get();
    return result.data();
  }

  Future<String> addMessage({
    required TeamId teamId,
    required Message message,
  }) async {
    final result =
        await _firestoreReferenceService.messagesCollection(teamId: teamId).add(
              message,
            );
    return result.id;
  }

  Future<void> setMessage({
    required MessageId messageId,
    required TeamId teamId,
    required Message message,
  }) async {
    final messageId = message.messageId;
    assert(
      messageId.value.isNotEmpty,
      'message must have a messageId: $message',
    );
    await _firestoreReferenceService
        .messageReference(
          messageId: messageId,
          teamId: teamId,
        )
        .set(
          message,
        );
  }

  Future<void> updateMessage({
    required MessageId messageId,
    required TeamId teamId,
    UpdatedValue<String>? content,
    UpdatedValue<DateTime?>? date,
  }) async {
    final data = {
      if (content != null) Message.contentFieldKey: content.value,
      if (date != null) Message.dateFieldKey: date.value,
    };
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService
        .messageReference(
          messageId: messageId,
          teamId: teamId,
        )
        .update(
          data,
        );
  }

  Future<void> deleteMessage({
    required MessageId messageId,
    required TeamId teamId,
  }) async {
    await _firestoreReferenceService
        .messageReference(
          messageId: messageId,
          teamId: teamId,
        )
        .delete();
  }

  Future<List<Task>> getTasksCollection() async {
    final result = await _firestoreReferenceService.tasksCollection().get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<List<Task>> getTasksCollectionWhere(
      {required Query<Task> Function(CollectionReference<Task>) where}) async {
    final collection = _firestoreReferenceService.tasksCollection();
    final result = await where(collection).get();
    return result.docs.map((snapshot) => snapshot.data()).toList();
  }

  Future<Task?> getTask({required TaskId taskId}) async {
    final result =
        await _firestoreReferenceService.taskReference(taskId: taskId).get();
    return result.data();
  }

  Future<String> addTask({required Task task}) async {
    final result = await _firestoreReferenceService.tasksCollection().add(task);
    return result.id;
  }

  Future<void> setTask({
    required TaskId taskId,
    required Task task,
  }) async {
    final taskId = task.taskId;
    assert(
      taskId.value.isNotEmpty,
      'task must have a taskId: $task',
    );
    await _firestoreReferenceService.taskReference(taskId: taskId).set(task);
  }

  Future<void> updateTask({
    required TaskId taskId,
    UpdatedValue<String>? name,
    UpdatedValue<String?>? description,
    UpdatedValue<bool>? done,
  }) async {
    final data = {
      if (name != null) Task.nameFieldKey: name.value,
      if (description != null) Task.descriptionFieldKey: description.value,
      if (done != null) Task.doneFieldKey: done.value,
    };
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService.taskReference(taskId: taskId).update(data);
  }

  Future<void> deleteTask({required TaskId taskId}) async {
    await _firestoreReferenceService.taskReference(taskId: taskId).delete();
  }
}

class UpdatedValue<T> {
  const UpdatedValue(
    this.value,
  );

  final T value;
}
