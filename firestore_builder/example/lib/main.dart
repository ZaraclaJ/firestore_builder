// Example app for firestore_builder.
//
// Everything under `lib/firestore/` is generated from
// `firestore_builder_config.yaml` by `dart run firestore_builder`, then
// completed by `dart run build_runner build --delete-conflicting-outputs`.
// This file only shows how that generated code is used from a widget tree.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/models/updated_value.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/team_states.dart';
import 'package:example/models/enums/team_size.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // This example is not wired to a Firebase project. To run it against
  // your own project, run `flutterfire configure` in this folder and pass
  // `options: DefaultFirebaseOptions.currentPlatform` below.
  await Firebase.initializeApp();
  // The generated providers need a ProviderScope above them.
  runApp(const ProviderScope(child: ExampleApp()));
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'firestore_builder example',
      home: TeamsPage(),
    );
  }
}

/// Lists the `teams` collection and lets the user add, edit and delete teams.
class TeamsPage extends ConsumerWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // `teamCollectionProvider` is generated in `firestore/states/`.
    // It rebuilds this widget on every Firestore snapshot and is null until
    // the first snapshot arrives. Watch `teamCollectionStreamProvider`
    // instead if you need the full AsyncValue with its error state.
    final teams = ref.watch(teamCollectionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Teams')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTeam(ref),
        child: const Icon(Icons.add),
      ),
      body: switch (teams) {
        null => const Center(child: CircularProgressIndicator()),
        [] => const Center(child: Text('No team yet. Tap + to add one.')),
        final teams => ListView(
          children: [for (final team in teams) _TeamTile(team: team)],
        ),
      },
    );
  }

  Future<void> _addTeam(WidgetRef ref) async {
    // `Team` is a Freezed model generated in `firestore/models/`.
    // Fields declared with `accept_field_value: true` in the config get a
    // companion `<field>FieldValue` parameter. When set, it is written
    // instead of the plain value, so the server fills `created_at` here.
    final team = Team(
      name: 'Team ${DateTime.now().second}',
      userCount: 0,
      createdAt: DateTime.now(),
      createdAtFieldValue: FieldValue.serverTimestamp(),
      labels: const ['new'],
      teamSize: TeamSize.solo,
    );
    // `firestoreQueryServiceProvider` is generated in `firestore/services/`.
    // It exposes add, set, update, delete and get methods per collection.
    await ref.read(firestoreQueryServiceProvider).addTeam(team: team);
  }
}

enum _TeamAction {
  rename('Rename'),
  nextSize('Next team size'),
  addLabel('Add a label'),
  delete('Delete');

  const _TeamAction(this.label);

  final String label;
}

class _TeamTile extends ConsumerWidget {
  const _TeamTile({required this.team});

  final Team team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(team.name),
      subtitle: Text(
        '${team.teamSize.name} team, labels: ${team.labels.join(', ')}',
      ),
      trailing: PopupMenuButton<_TeamAction>(
        onSelected: (action) => _onAction(ref, action),
        itemBuilder: (context) => [
          for (final action in _TeamAction.values)
            PopupMenuItem(value: action, child: Text(action.label)),
        ],
      ),
    );
  }

  Future<void> _onAction(WidgetRef ref, _TeamAction action) async {
    final service = ref.read(firestoreQueryServiceProvider);
    // Every model carries its document id, filled when read from Firestore.
    final teamId = team.teamId;

    switch (action) {
      case _TeamAction.rename:
        // `updateTeam` takes one optional `UpdatedValue` per field and only
        // writes the fields you pass. Wrapping is what makes it possible to
        // update a nullable field to null: `description: UpdatedValue(null)`.
        await service.updateTeam(
          teamId: teamId,
          name: UpdatedValue('${team.name}!'),
        );
      case _TeamAction.nextSize:
        // Enum fields get a dedicated wrapper, generated next to
        // `UpdatedValue`, so the enum is serialized like it is in the model.
        const sizes = TeamSize.values;
        final next = sizes[(team.teamSize.index + 1) % sizes.length];
        await service.updateTeam(
          teamId: teamId,
          teamSize: UpdatedValueTeamSize(next),
        );
      case _TeamAction.addLabel:
        // `accept_field_value: true` fields can also be updated with any
        // Firestore `FieldValue`, here an atomic array union.
        await service.updateTeam(
          teamId: teamId,
          labelsFieldValue: UpdatedValue(FieldValue.arrayUnion(['edited'])),
        );
      case _TeamAction.delete:
        await service.deleteTeam(teamId: teamId);
    }
  }
}
