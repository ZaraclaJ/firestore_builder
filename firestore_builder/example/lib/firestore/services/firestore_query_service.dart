import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/task.dart';
import 'package:example/firestore/models/team.dart';
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

  Future<Team?> getTeam(TeamId teamId) async {
    final result = await _firestoreReferenceService.teamReference(teamId).get();
    return result.data();
  }

  Future<String> addTeam(Team team) async {
    final result = await _firestoreReferenceService.teamsCollection().add(team);
    return result.id;
  }

  Future<void> setTeam(Team team) async {
    final teamId = team.teamId;
    assert(
      teamId.value.isNotEmpty,
      'team must have a teamId: $team',
    );
    await _firestoreReferenceService.teamReference(teamId).set(team);
  }

  Future<void> updateTeam({
    required TeamId teamId,
    UpdatedValue<String>? name,
    UpdatedValue<String?>? description,
    UpdatedValue<int>? userCount,
    UpdatedValue<DateTime>? createdAt,
  }) async {
    final data = {
      if (name != null) Team.nameFieldKey: name.value,
      if (description != null) Team.descriptionFieldKey: description.value,
      if (userCount != null) Team.userCountFieldKey: userCount.value,
      if (createdAt != null) Team.createdAtFieldKey: createdAt.value,
    };
    if (data.isEmpty) {
      return;
    }
    await _firestoreReferenceService.teamReference(teamId).update(data);
  }

  Future<void> deleteTeam(TeamId teamId) async {
    await _firestoreReferenceService.teamReference(teamId).delete();
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

  Future<Task?> getTask(TaskId taskId) async {
    final result = await _firestoreReferenceService.taskReference(taskId).get();
    return result.data();
  }

  Future<String> addTask(Task task) async {
    final result = await _firestoreReferenceService.tasksCollection().add(task);
    return result.id;
  }

  Future<void> setTask(Task task) async {
    final taskId = task.taskId;
    assert(
      taskId.value.isNotEmpty,
      'task must have a taskId: $task',
    );
    await _firestoreReferenceService.taskReference(taskId).set(task);
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
    await _firestoreReferenceService.taskReference(taskId).update(data);
  }

  Future<void> deleteTask(TaskId taskId) async {
    await _firestoreReferenceService.taskReference(taskId).delete();
  }
}

class UpdatedValue<T> {
  const UpdatedValue(
    this.value,
  );

  final T value;
}
