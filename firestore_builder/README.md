# Firestore Builder

[![Pub](https://img.shields.io/pub/v/firestore_builder.svg)](https://pub.dev/packages/firestore_builder)

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/social_card.png" width="600" />

Describe your Firestore database once, in a YAML file, and let `firestore_builder` generate the
Dart code you would otherwise write by hand: Freezed models with `fromFirestore` / `toFirestore`,
typed document ids, typed field keys, a reference service, a query service (get, add, set, update,
delete), a stream service and, if you want them, Riverpod providers. Subcollections, enums,
`DateTime`, `Timestamp`, `DocumentReference` and `FieldValue` are handled. Generation is two
commands: `dart run firestore_builder`, then the usual `build_runner` pass for Freezed.

## Why use it

- **One YAML file is the whole schema.** Collections, subcollections, fields, types and
  nullability live in `firestore_builder_config.yaml`. Change the file, run the commands, the
  Dart code follows.
- **Typed models.** Every collection becomes a Freezed class: immutable, value equality,
  `copyWith`, `toJson` / `fromJson`, plus a `fromFirestore(snapshot)` factory and a
  `toFirestore()` method wired into `withConverter`.
- **Typed document ids.** `TeamId`, `UserId`, `TaskId`: the compiler stops you from passing a
  user id where a team id is expected.
- **Typed field keys.** `Team.nameFieldKey`, `Team.collectionKey`: no string literals in your
  queries.
- **Three generated services.** `FirestoreReferenceService` (typed references),
  `FirestoreQueryService` (one-shot reads and writes) and `FirestoreStreamService` (real-time
  streams). Every collection and subcollection gets its methods, and parent ids are required
  named parameters, so you cannot forget one.
- **Partial updates.** `updateTeam(teamId: id, name: UpdatedValue('Blue'))` writes only the
  fields you pass. Fields declared with `accept_field_value: true` also accept
  `FieldValue.serverTimestamp()`, `FieldValue.arrayUnion(...)`, `FieldValue.increment(...)`
  and `FieldValue.delete()`.
- **Riverpod providers, optional.** With `use_riverpod: true` you get a document provider and
  a collection provider (stream and plain value) per collection, plus providers for the
  services.
- **Enums with a fallback.** `unknown_enum_value` decodes values your app does not know yet
  (written by a newer version, for instance) to a fallback instead of throwing.
- **A DevTools extension** to build the configuration file visually.
- **Safe to regenerate.** The output folder is cleared and rebuilt on every run (configurable).

## Table of contents

- [Quick start](#quick-start)
- [Configuration reference](#configuration-reference)
- [Generated code walkthrough](#generated-code-walkthrough)
- [DevTools extension](#devtools-extension)
- [Workflow and tips](#workflow-and-tips)
- [Limitations and FAQ](#limitations-and-faq)
- [Contributing and license](#contributing-and-license)

## Quick start

### 1. Add the dependencies

Set up Firebase for your app by following the
[official guide](https://firebase.google.com/docs/flutter/setup), then add:

```bash
flutter pub add firebase_core cloud_firestore freezed_annotation json_annotation
flutter pub add dev:firestore_builder dev:build_runner dev:freezed dev:json_serializable
```

If you want the generated providers (`use_riverpod: true`), also add:

```bash
flutter pub add flutter_riverpod
```

The generated models use the `abstract class` syntax, so they work with Freezed 3 and later.
Tested with `freezed ^3.0.0`, `flutter_riverpod ^2.6.1` and `cloud_firestore ^6.8.0` (the
example app's pins).

### 2. Describe your database

Create `firestore_builder_config.yaml` at the root of your project (next to `pubspec.yaml`):

```yaml
firestore_builder:
  project_name: my_app      # must be the `name` of your pubspec.yaml
  output: lib/firestore     # where the code is generated, must be under lib/
  use_riverpod: true        # optional, default false
  collections:
    - collection:
        collection_name: tasks
        model_name: task
        fields:
          - name: String
          - description: String?
          - done: bool
```

### 3. Generate

```bash
dart run firestore_builder
dart run build_runner build --delete-conflicting-outputs
```

The first command writes the `.dart` sources, the second one lets Freezed and json_serializable
produce the `.freezed.dart` and `.g.dart` parts.

### 4. Use the generated code

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/firestore/models/task.dart';
import 'package:my_app/firestore/models/updated_value.dart';
import 'package:my_app/firestore/services/firestore_query_service.dart';
import 'package:my_app/firestore/services/firestore_reference_service.dart';

final service = FirestoreQueryService(
  firestoreReferenceService: FirestoreReferenceService(
    firestore: FirebaseFirestore.instance,
  ),
);

final id = await service.addTask(task: const Task(name: 'Write the docs', done: false));
final tasks = await service.getTasksCollection();
await service.updateTask(taskId: TaskId(id), done: const UpdatedValue(true));
await service.deleteTask(taskId: TaskId(id));
```

With Riverpod, the services are already provided and each collection has its providers:

```dart
class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Task>?: null until the first snapshot arrives, then always up to date.
    final tasks = ref.watch(taskCollectionProvider);
    if (tasks == null) {
      return const CircularProgressIndicator();
    }
    return ListView(children: [for (final task in tasks) Text(task.name)]);
  }
}
```

## Configuration reference

### Top-level keys

Everything sits under a single `firestore_builder:` key.

| Key | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `project_name` | String | yes | | The `name` from your `pubspec.yaml`. Generated files import each other and your custom classes as `package:<project_name>/...`. |
| `output` | String | yes | | Output folder, relative to the directory you run the command from (normally the project root). It must be under `lib/`, for example `lib/firestore`: generated files import each other as `package:<project_name>/<output minus lib/>/...`. |
| `clear_output_folder` | bool | no | `true` | Delete every `.dart` file under `output`, recursively, before generating. |
| `use_riverpod` | bool | no | `false` | Also generate Riverpod providers: a `states/` file per collection and one provider per service. |
| `collections` | list | no | `[]` | The top-level collections (see below). |

Unknown keys are ignored silently, so double check the spelling if an option seems to have no
effect. A missing `firestore_builder` section, `project_name` or `output` stops the generation
with an explicit error.

### Collections

Each item of `collections` is a map with a `collection` entry and, optionally, a
`sub_collections` entry **next to it** (not inside it). Subcollections use exactly the same
structure and can be nested to any depth.

```yaml
collections:
  - collection:
      collection_name: teams      # Firestore collection id
      model_name: team            # base name of the generated Dart classes
      fields:
        - name: String
    sub_collections:              # sibling of `collection`
      - collection:
          collection_name: users
          model_name: user
          fields:
            - name: String
```

| Key | Type | Required | Description |
| --- | --- | --- | --- |
| `collection_name` | String | yes | The Firestore collection id, used as is in Firestore paths. Also drives collection level method names, recased as needed: `teamsCollection()`, `getTeamsCollection()`, `teamsCollectionStream()`. |
| `model_name` | String | yes | Base name of the generated classes, file and document level methods, recased as needed: `model_name: team_member` gives `TeamMember`, `TeamMemberId`, `team_member.dart`, `getTeamMember()`, `teamMemberProvider`. Must be unique across the whole configuration, subcollections included, because all models go to the same `models/` folder. |
| `fields` | list | no | The document fields. A collection without fields still gets a model holding its id. |
| `sub_collections` | list | no | Nested collections, same structure as `collections`. Declared as a sibling of `collection`, not inside it (see the structure above). |

### Fields

A field is a one-entry map. The key is the Firestore field name, kept exactly as written. The
value is either a type (short form) or a map (long form):

```yaml
fields:
  - user_count: int                   # short form: `<firestore key>: <type>`
  - created_at:                       # long form
      type: DateTime
      accept_field_value: true
  - team_size:
      type: TeamSize
      path: models/enums/team_size.dart
      unknown_enum_value: small
```

The Dart property is the camelCase version of the key: `user_count` becomes `userCount`, and the
constant `Team.userCountFieldKey` holds `'user_count'` for queries.

| Key | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `type` | String | yes | | One of the supported types below. |
| `accept_field_value` | bool | no | `false` | Let the field be written with a `FieldValue` (see [accept_field_value](#accept_field_value)). |
| `path` | String | for custom types | | Path of the Dart file declaring the class or enum, relative to `lib/` (a leading `lib/` is accepted and stripped). Imported as `package:<project_name>/<path>`. |
| `unknown_enum_value` | String | no | | Enum value used when Firestore holds a value the enum does not declare (see [Custom classes and enums](#custom-classes-and-enums)). |

### Supported types

| YAML type | Dart type | Notes |
| --- | --- | --- |
| `String` | `String` | |
| `int` | `int` | |
| `double` | `double` | |
| `bool` | `bool` | |
| `DateTime` | `DateTime` | Stored as a Firestore `Timestamp`. The generated `DateTimeConverter` converts in both directions. |
| `Timestamp` | `Timestamp` (cloud_firestore) | Passed through untouched by the generated `TimestampConverter`. |
| `DocumentReference` | `DocumentReference` (cloud_firestore) | Passed through untouched by the generated `DocumentReferenceConverter`. |
| `List<T>` | `List<T>` | `T` is any supported type, including another `List`, a `Map` or a custom class. |
| `Map<String, T>` | `Map<String, T>` | Keys must be `String`. `T` is any supported type. |
| any other name, with `path` | your class or enum | See below. |

**Nullability**: append `?` to a type, at any level: `String?`, `List<Timestamp?>?`,
`Map<String, bool>?`. Non-nullable fields become `required` constructor parameters, nullable
ones are optional.

A type that is not in this table and has no `path` stops the generation with
`Type X is not recognized`.

### Custom classes and enums

Any type name that is not built in is treated as a custom class as soon as `path` is given. The
generator only needs the name and the file: the field is declared with that type and the file is
imported. Serialization is left to json_serializable, which means:

- an **enum** is stored by its value name (or its `@JsonValue`), nothing else to do;
- a **class** must expose a `fromJson(Map<String, dynamic>)` factory and a `toJson()` method
  (a Freezed class with `fromJson` does).

`unknown_enum_value` is emitted as `@JsonKey(unknownEnumValue: TeamSize.small)`. Rules:

- it is only accepted on a field whose type is a custom class declared with `path`, directly or
  inside a `List`; anything else fails with
  `unknown_enum_value requires an enum type declared with path`;
- it is refused on `Map<String, MyEnum>` values
  (`unknown_enum_value is not supported on Map values`);
- the value must be one of the enum's constants. The generator does not check this, the Dart
  analyzer will flag the generated model if it is wrong;
- it only applies to **unknown, non-null** values. A missing or `null` value for a non-nullable
  enum field still throws at decode time, as with any required field. Declare the field
  nullable (`TeamSize?`) if it may be absent.

### accept_field_value

Set `accept_field_value: true` on a field that you want to write with a Firestore `FieldValue`
(`serverTimestamp`, `arrayUnion`, `arrayRemove`, `increment`, `delete`). The generator adds:

- a `FieldValue? <field>FieldValue` property on the model, excluded from JSON, that
  `toFirestore()` writes in place of the regular value when it is not null;
- an `UpdatedValue<FieldValue?>? <field>FieldValue` parameter on the `update<Model>` method.

```dart
// Let the server set created_at: the DateTime passed here is overridden on write.
final team = Team(
  name: 'Blue',
  userCount: 0,
  createdAt: DateTime.now(),
  labels: const [],
  teamSize: TeamSize.small,
  createdAtFieldValue: FieldValue.serverTimestamp(),
);
await queryService.addTeam(team: team);

// Append to the labels array without reading the document.
await queryService.updateTeam(
  teamId: teamId,
  labelsFieldValue: UpdatedValue(FieldValue.arrayUnion(['vip'])),
);
```

### Full annotated example

This configuration is adapted from the package's own test configuration
(`test/firestore_builder_config.yaml`); every snippet of generated code in this README comes
from it.

```yaml
firestore_builder:
  project_name: firestore_builder
  output: test/output
  use_riverpod: true
  collections:
    - collection:
        collection_name: teams
        model_name: team
        fields:
          - name: String
          - description: String?
          - user_count: int
          - created_at:                        # DateTime, writable with a FieldValue
              type: DateTime
              accept_field_value: true
          - dates: List<Timestamp?>?           # nullable list of nullable timestamps
          - bytes: List<List<int>>?            # nested lists
          - labels:
              type: List<String>
              accept_field_value: true         # arrayUnion / arrayRemove
          - presences: Map<String, bool>?      # String keys only
          - team_ref: DocumentReference?
          - team_size:                         # enum declared in lib/models/enums/team_size.dart
              type: TeamSize
              path: models/enums/team_size.dart
              unknown_enum_value: small
          - team_sizes:                        # list of enums, same fallback
              type: List<TeamSize>?
              path: models/enums/team_size.dart
              unknown_enum_value: small
      sub_collections:                         # teams/{teamId}/users
        - collection:
            collection_name: users
            model_name: user
            fields:
              - name: String
              - current_job: String?
              - age: int
          sub_collections:                     # teams/{teamId}/users/{userId}/items
            - collection:
                collection_name: items
                model_name: item
                fields:
                  - name: String
        - collection:                          # teams/{teamId}/messages
            collection_name: messages
            model_name: message
            fields:
              - content: String
              - date: Timestamp?
    - collection:
        collection_name: tasks
        model_name: task
        fields:
          - name: String
          - description: String?
          - done: bool
```

## Generated code walkthrough

For the configuration above, with `output: lib/firestore`, the generator writes:

```text
lib/firestore/
├── converters/
│   └── freezed_converters.dart       # only if DateTime, Timestamp or DocumentReference is used
├── models/
│   ├── team.dart                     # Team, TeamId
│   ├── user.dart                     # User, UserId, UserPath
│   ├── item.dart                     # Item, ItemId, ItemPath
│   ├── message.dart                  # Message, MessageId, MessagePath
│   ├── task.dart                     # Task, TaskId
│   └── updated_value.dart            # UpdatedValue<T> and one class per custom type
├── services/
│   ├── firestore_reference_service.dart
│   ├── firestore_query_service.dart
│   └── firestore_stream_service.dart
└── states/                           # only with use_riverpod: true
    ├── team_states.dart
    ├── user_states.dart
    ├── item_states.dart
    ├── message_states.dart
    └── task_states.dart
```

`build_runner` then adds a `.freezed.dart` and a `.g.dart` part next to each model. All files are
formatted with `dart_style`.

### Naming at a glance

From `collection_name: teams` and `model_name: team`:

| Generated | Name |
| --- | --- |
| Model, id, path classes | `Team`, `TeamId`, `TeamPath` (path only for subcollections) |
| Keys | `Team.collectionKey`, `Team.nameFieldKey`, `Team.userCountFieldKey`, ... |
| Reference service | `teamsCollection()`, `teamReference()` |
| Query service | `getTeamsCollection()`, `getTeamsCollectionWhere()`, `getTeam()`, `addTeam()`, `setTeam()`, `updateTeam()`, `deleteTeam()` |
| Stream service | `teamsCollectionStream()`, `teamsCollectionWhereStream()`, `teamStream()` |
| Riverpod | `teamStreamProvider`, `teamProvider`, `teamCollectionStreamProvider`, `teamCollectionProvider` |

### Models

`models/team.dart` (trimmed):

```dart
@Freezed(toJson: true, fromJson: true)
abstract class Team with _$Team {
  const factory Team({
    @JsonKey(name: Team.nameFieldKey) required String name,
    @JsonKey(name: Team.userCountFieldKey) required int userCount,
    @DateTimeConverter()
    @JsonKey(name: Team.createdAtFieldKey)
    required DateTime createdAt,
    @JsonKey(name: Team.labelsFieldKey) required List<String> labels,
    @JsonKey(name: Team.teamSizeFieldKey, unknownEnumValue: TeamSize.small)
    required TeamSize teamSize,
    @JsonKey(name: Team.descriptionFieldKey) String? description,
    @TimestampConverter()
    @JsonKey(name: Team.datesFieldKey)
    List<Timestamp?>? dates,
    @JsonKey(name: Team.presencesFieldKey) Map<String, bool>? presences,
    @DocumentReferenceConverter()
    @JsonKey(name: Team.teamRefFieldKey)
    DocumentReference? teamRef,
    @JsonKey(includeFromJson: false, includeToJson: false)
    FieldValue? createdAtFieldValue,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(TeamId(''))
    TeamId teamId,
  }) = _Team;

  factory Team.fromFirestore(DocumentSnapshot<Map<String, Object?>> snapshot) {
    final data = snapshot.data();
    return Team.fromJson(data!).copyWith(teamId: TeamId(snapshot.id));
  }

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  const Team._();

  static const String collectionKey = 'teams';
  static const String nameFieldKey = 'name';
  static const String userCountFieldKey = 'user_count';
  // ... one constant per field

  Map<String, Object?> toFirestore() {
    final json = toJson();
    if (createdAtFieldValue != null) {
      json[createdAtFieldKey] = createdAtFieldValue;
    }
    // ... same for labelsFieldValue
    return json;
  }
}

@Freezed(toJson: true, fromJson: true)
abstract class TeamId with _$TeamId {
  const factory TeamId(String value) = _TeamId;
  factory TeamId.fromJson(Map<String, dynamic> json) => _$TeamIdFromJson(json);
}
```

What to know:

- the document id is **not** a Firestore field. `teamId` is excluded from JSON and filled by
  `fromFirestore` from `snapshot.id`. A model you build yourself has `TeamId('')` until it is
  read back from Firestore;
- `TeamId` is a Freezed value class: two ids with the same `value` are equal, which makes them
  safe as provider family arguments and map keys;
- models of subcollections get an extra `<Model>Path` class bundling the document id and all
  parent ids, used as the family argument of the Riverpod providers:

```dart
@Freezed(toJson: true, fromJson: true)
abstract class UserPath with _$UserPath {
  const factory UserPath({required UserId userId, required TeamId teamId}) = _UserPath;
  factory UserPath.fromJson(Map<String, dynamic> json) => _$UserPathFromJson(json);
}
```

### Converters

`converters/freezed_converters.dart` is generated only when at least one field uses `DateTime`,
`Timestamp` or `DocumentReference`, and it only contains the converters that are needed. The
`DateTime` one is the only real conversion:

```dart
class DateTimeConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}
```

`TimestampConverter` and `DocumentReferenceConverter` return their input unchanged: they exist
so json_serializable accepts these Firestore types in `toJson` / `fromJson`.

### UpdatedValue

`models/updated_value.dart` holds the wrapper used by every `update<Model>` method. Wrapping the
value is what lets the method tell "not passed" (`null` parameter, field untouched) from
"set to null" (`UpdatedValue(null)`, field written as `null`).

```dart
class UpdatedValue<T> {
  const UpdatedValue(this.value);

  final T value;
}
```

Custom classes get their own wrapper so the value can be serialized before being sent. One class
is generated per custom type, shared between its nullable and non-nullable uses, and `List` /
`Map` of a custom type get a `List` / `Map` suffixed variant:

```dart
@Freezed(toJson: true, fromJson: true)
abstract class UpdatedValueTeamSize with _$UpdatedValueTeamSize {
  const factory UpdatedValueTeamSize(TeamSize teamSize) = _UpdatedValueTeamSize;
  // ...
  Object? get value => toJson()['teamSize'];
}

@Freezed(toJson: true, fromJson: true)
abstract class UpdatedValueTeamSizeList with _$UpdatedValueTeamSizeList {
  const factory UpdatedValueTeamSizeList(List<TeamSize>? teamSizeList) =
      _UpdatedValueTeamSizeList;
  // ...
  Object? get value => toJson()['teamSizeList'];
}
```

### Reference service

`services/firestore_reference_service.dart` is the only place that touches `FirebaseFirestore`.
It exposes a typed `CollectionReference` and `DocumentReference` per collection, with the
`withConverter` wiring done for you. Subcollections require their parent ids:

```dart
class FirestoreReferenceService {
  const FirestoreReferenceService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;

  CollectionReference<Team> teamsCollection() {
    return _firestore
        .collection(Team.collectionKey)
        .withConverter(
          fromFirestore: (snapshot, _) {
            return Team.fromFirestore(snapshot);
          },
          toFirestore: (value, _) {
            return value.toFirestore();
          },
        );
  }

  DocumentReference<Team> teamReference({required TeamId teamId}) {
    return teamsCollection().doc(teamId.value);
  }

  CollectionReference<User> usersCollection({required TeamId teamId}) {
    return teamReference(teamId: teamId)
        .collection(User.collectionKey)
        .withConverter(/* same pattern */);
  }

  DocumentReference<User> userReference({
    required UserId userId,
    required TeamId teamId,
  }) {
    return usersCollection(teamId: teamId).doc(userId.value);
  }
  // ... itemsCollection, itemReference, messagesCollection, ...
}
```

Use it directly whenever you need something the other services do not cover (batches,
transactions, pagination, `limit`, and so on):

```dart
final batch = FirebaseFirestore.instance.batch();
batch.set(referenceService.teamReference(teamId: teamId), team);
await batch.commit();
```

### Query service

`services/firestore_query_service.dart` wraps the reference service with one-shot operations.
For every collection:

| Method | Returns | Notes |
| --- | --- | --- |
| `getTeamsCollection()` | `Future<List<Team>>` | Whole collection. |
| `getTeamsCollectionWhere({required where})` | `Future<List<Team>>` | `where` receives the typed `CollectionReference<Team>` and returns a `Query<Team>`. |
| `getTeam({required teamId})` | `Future<Team?>` | `null` if the document does not exist. |
| `addTeam({required team})` | `Future<String>` | Auto generated id, returned. |
| `setTeam({required teamId, required team})` | `Future<void>` | Writes the whole document at `teamId`. |
| `updateTeam({required teamId, ...})` | `Future<void>` | One optional `UpdatedValue` parameter per field. |
| `deleteTeam({required teamId})` | `Future<void>` | |

Subcollection methods add the parent ids as required named parameters:
`getUsersCollection({required teamId})`,
`getItem({required itemId, required teamId, required userId})`, and so on.

```dart
// Query with typed keys.
final doneTasks = await queryService.getTasksCollectionWhere(
  where: (collection) => collection
      .where(Task.doneFieldKey, isEqualTo: true)
      .orderBy(Task.nameFieldKey),
);

// Subcollection: the parent id is part of the signature.
final users = await queryService.getUsersCollection(teamId: teamId);
final userId = await queryService.addUser(
  teamId: teamId,
  user: const User(name: 'Ada', age: 36),
);

// Partial update: only `name`, `description` and `team_size` are written.
await queryService.updateTeam(
  teamId: teamId,
  name: const UpdatedValue('Blue team'),
  description: const UpdatedValue(null),        // sets description to null
  teamSize: const UpdatedValueTeamSize(TeamSize.large),
);
```

The generated `updateTeam` shows how the partial update is built:

```dart
Future<void> updateTeam({
  required TeamId teamId,
  UpdatedValue<String>? name,
  UpdatedValue<String?>? description,
  UpdatedValue<int>? userCount,
  UpdatedValue<DateTime>? createdAt,
  // ...
  UpdatedValueTeamSize? teamSize,
  UpdatedValueTeamSizeList? teamSizes,
  UpdatedValue<FieldValue?>? createdAtFieldValue,
  UpdatedValue<FieldValue?>? labelsFieldValue,
}) async {
  final data = {
    if (name != null) Team.nameFieldKey: name.value,
    if (description != null) Team.descriptionFieldKey: description.value,
    if (teamSize != null) Team.teamSizeFieldKey: teamSize.value,
    if (createdAtFieldValue != null)
      Team.createdAtFieldKey: createdAtFieldValue.value,
    // ...
  };
  if (data.isEmpty) {
    return;
  }
  await _firestoreReferenceService.teamReference(teamId: teamId).update(data);
}
```

About `set<Model>`: `setTeam(teamId: id, team: team)` writes `team` at the document `id`,
creating it or replacing it entirely. The `team.teamId` carried by the model is ignored (it is
excluded from JSON anyway), so there is nothing to synchronize between the two arguments. For
subcollections the parent ids come from the parameters as well.

### Stream service

`services/firestore_stream_service.dart` mirrors the read side of the query service with
`Stream`s backed by `snapshots()`:

```dart
Stream<List<Team>> teamsCollectionStream();
Stream<List<Team>> teamsCollectionWhereStream({
  required Query<Team> Function(CollectionReference<Team>) where,
});
Stream<Team?> teamStream({required TeamId teamId});

Stream<List<User>> usersCollectionStream({required TeamId teamId});
Stream<User?> userStream({required UserId userId, required TeamId teamId});
```

```dart
StreamBuilder<List<Task>>(
  stream: streamService.tasksCollectionWhereStream(
    where: (collection) => collection.where(Task.doneFieldKey, isEqualTo: false),
  ),
  builder: (context, snapshot) => Text('${snapshot.data?.length ?? 0} tasks left'),
);
```

### Riverpod states

With `use_riverpod: true`, every service file also declares its provider, all `autoDispose`:

```dart
final firestoreProvider = Provider.autoDispose<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
final firestoreReferenceServiceProvider =
    Provider.autoDispose<FirestoreReferenceService>((ref) {
      return FirestoreReferenceService(firestore: ref.watch(firestoreProvider));
    }, dependencies: [firestoreProvider]);
final firestoreQueryServiceProvider = Provider.autoDispose<FirestoreQueryService>(...);
final firestoreStreamServiceProvider = Provider.autoDispose<FirestoreStreamService>(...);
```

To point every generated service at another instance (the emulator, a fake in tests), override
`firestoreProvider`:

```dart
ProviderScope(
  overrides: [firestoreProvider.overrideWithValue(fakeFirestore)],
  child: const MyApp(),
);
```

Every generated provider lists in `dependencies` the providers its body reads. That is what
makes the override above reach them from a `ProviderScope` nested under the root one: without
the declaration, a nested scope keeps serving the root instance and the override silently does
nothing.

Without Riverpod, pass the instance to `FirestoreReferenceService(firestore: ...)` yourself.

Each collection gets a `states/<model>_states.dart` file with four providers. Here is
`states/team_states.dart`:

```dart
final teamStreamProvider = StreamProvider.autoDispose.family<Team?, TeamId>((
  ref,
  teamId,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.teamStream(teamId: teamId);
}, dependencies: [firestoreStreamServiceProvider]);
final teamProvider = Provider.autoDispose.family<Team?, TeamId>((ref, teamId) {
  final stream = ref.watch(teamStreamProvider(teamId));
  return stream.value;
}, dependencies: [teamStreamProvider]);
final teamCollectionStreamProvider = StreamProvider.autoDispose<List<Team>>((
  ref,
) {
  final service = ref.watch(firestoreStreamServiceProvider);
  return service.teamsCollectionStream();
}, dependencies: [firestoreStreamServiceProvider]);
final teamCollectionProvider = Provider.autoDispose<List<Team>?>((ref) {
  final stream = ref.watch(teamCollectionStreamProvider);
  return stream.value;
}, dependencies: [teamCollectionStreamProvider]);
```

- `<model>StreamProvider` and `<model>CollectionStreamProvider` expose the `AsyncValue`
  (loading, error, data);
- `<model>Provider` and `<model>CollectionProvider` return `AsyncValue.value`: `null` only
  during the first load, the previous value while the stream reloads, and if the stream errors
  before producing a value the plain provider rethrows. Watch `<model>StreamProvider` when you
  need to handle `AsyncError`.

Subcollections are families keyed by the parent: the document providers take the
`<Model>Path`, the collection providers take the parent's id (`TeamId` for a direct child) or
the parent's path (`UserPath` for deeper levels):

```dart
// states/user_states.dart
final userProvider = Provider.autoDispose.family<User?, UserPath>(...);
final userCollectionProvider = Provider.autoDispose.family<List<User>?, TeamId>(...);

// states/item_states.dart
final itemProvider = Provider.autoDispose.family<Item?, ItemPath>(...);
final itemCollectionProvider = Provider.autoDispose.family<List<Item>?, UserPath>(...);
```

```dart
class UserDetails extends ConsumerWidget {
  const UserDetails({required this.teamId, required this.userId, super.key});

  final TeamId teamId;
  final UserId userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = UserPath(userId: userId, teamId: teamId);
    final user = ref.watch(userProvider(path));
    final items = ref.watch(itemCollectionProvider(path));

    if (user == null) {
      return const CircularProgressIndicator();
    }
    return Text('${user.name} has ${items?.length ?? 0} items');
  }
}
```

Writes go through the query service provider:

```dart
await ref.read(firestoreQueryServiceProvider).updateUser(
      userId: userId,
      teamId: teamId,
      age: const UpdatedValue(37),
    );
```

## DevTools extension

The package ships a DevTools extension that builds the configuration file for you. It reads
`project_name` from your `pubspec.yaml`, loads an existing `firestore_builder_config.yaml` if
there is one, and saves the file at the root of your project.

- Launch your app in debug mode
- Open DevTools

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/open_devtools.png" width="600" />

- Select the firestore_builder tab and enable the extension (DevTools records the choice in
  `devtools_options.yaml` at the root of your project)

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/enable_firestore_builder.png" width="600" />

- Build the configuration: collections, subcollections, fields, types, `accept_field_value`,
  `path` and `unknown_enum_value` for custom classes

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/devtools_tabs.jpg" width="600" />

- Save: this writes `firestore_builder_config.yaml` at the root of your project. Then run the
  two generation commands as usual

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/save_config.png" width="600" />

## Workflow and tips

- **Run both commands after every change to the config**:
  `dart run firestore_builder` then `dart run build_runner build --delete-conflicting-outputs`.
  The generator only writes the plain `.dart` sources; Freezed and json_serializable parts come
  from `build_runner`.
- **Keep `output` under `lib/`.** Generated files import each other through
  `package:<project_name>/<output minus lib/>/...`, so an output folder outside `lib/` produces
  imports that do not resolve.
- **The output folder belongs to the generator.** With the default `clear_output_folder: true`,
  every `.dart` file under `output` is deleted before generating, recursively, including files
  you may have added there. Keep your own code outside `output`. Set
  `clear_output_folder: false` if you need to keep the folder untouched, knowing that files for
  removed collections will then linger.
- **Commit the generated code.** It is plain Dart, reviewable in pull requests, and your app
  compiles without running the generator. Whether you also commit the `.freezed.dart` / `.g.dart`
  parts is the same decision as for the rest of your codebase.
- **Custom config path.** `dart run firestore_builder path/to/config.yaml`. The file must end
  with `.yaml`. Only the config file path and the `output` folder are resolved against the
  directory you run the command from; a field `path` is never resolved against it, it becomes
  `package:<project_name>/<path minus lib/>` as is.
- **Quoting types in YAML.** `Map<String, bool>?` and `List<Timestamp?>?` work unquoted in the
  test configuration. If your YAML tooling complains about `<`, `,` or `?`, quote the type:
  `"Map<String, bool>?"`.
- **Nested custom classes and `explicit_to_json`.** json_serializable only calls `toJson()` on
  nested objects when `explicit_to_json` is enabled. If a field holds a custom class (not an
  enum), add a `build.yaml` at your project root:

  ```yaml
  targets:
    $default:
      builders:
        json_serializable:
          options:
            explicit_to_json: true
  ```

## Limitations and FAQ

**Unsupported Firestore types.** `GeoPoint`, `Blob`, `num`, `dynamic` and any other type not in
the [supported types](#supported-types) table are rejected with `Type X is not recognized`.
`path` cannot rescue them: it only imports a file of your own package
(`package:<project_name>/...`) and no converter is generated for them.

**Nested maps.** The map value type must not contain a comma, so
`Map<String, Map<String, T>>` is not parsed; `Map<String, List<T>>` is fine. Put the inner map
in a custom class with `fromJson` / `toJson` instead.

**Why does my new model have an empty id?** Ids are assigned by Firestore. `addTeam` returns the
new id as a `String`; read the document back, or `copyWith(teamId: TeamId(id))`, to get a model
with its id set.

**`teamProvider` returns `null`: loading, missing or error?** `<model>Provider` unwraps
`AsyncValue.value`, so `null` means "no snapshot yet" or "document does not exist", and a stream
error before the first value is rethrown by the provider. Watch `<model>StreamProvider` when you
need to tell the cases apart or handle `AsyncError`.

**Does the generator validate Firestore rules or indexes?** No. It generates client code only.

## Contributing and license

Issues and pull requests are welcome on
[GitHub](https://github.com/ZaraclaJ/firestore_builder). The generator is exercised by
`test/src/generators_test.dart`, which regenerates `test/output/` from
`test/firestore_builder_config.yaml`.

Released under the [MIT license](LICENSE).
