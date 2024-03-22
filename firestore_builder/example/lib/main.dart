import 'package:example/firebase_options.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/team_states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: NameInput(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: AddTeamButton(),
            ),
            Expanded(
              child: TeamList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NameInput extends ConsumerWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Team name',
      ),
      onChanged: (value) {
        ref.read(nameProvider.notifier).state = value;
      },
    );
  }
}

class AddTeamButton extends ConsumerWidget {
  const AddTeamButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: ref.watch(nameProvider.select((value) => value.isEmpty))
          ? null
          : () {
              final name = ref.read(nameProvider);
              final team = Team(
                name: name,
                userCount: 0,
                createdAt: DateTime.now(),
              );
              ref.read(firestoreQueryServiceProvider).addTeam(team: team);
              ref.invalidate(nameProvider);
            },
      child: const Text('Add'),
    );
  }
}

class TeamList extends ConsumerWidget {
  const TeamList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(teamCollectionProvider);
    if (teamList == null) {
      return const CircularProgressIndicator();
    }

    if (teamList.isEmpty) {
      return const Text('No team in database. Add some teams.');
    }

    return ListView.separated(
      itemCount: teamList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final team = teamList[index];
        return ListTile(
          title: Text(team.name),
          subtitle: Text(team.description ?? 'No description'),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              ref.read(firestoreQueryServiceProvider).deleteTeam(
                    teamId: team.teamId,
                  );
            },
          ),
        );
      },
    );
  }
}
