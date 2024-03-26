import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/team_states.dart';
import 'package:example/pages/team_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Teams'),
      ),
      body: const _Layout(),
    );
  }
}

class _Layout extends StatefulWidget {
  const _Layout();

  @override
  State<_Layout> createState() => _LayoutState();
}

class _LayoutState extends State<_Layout> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: _NameInput(
              controller: _controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: _AddTeamButton(
              controller: _controller,
            ),
          ),
          const Expanded(
            child: _TeamList(),
          ),
        ],
      ),
    );
  }
}

class _NameInput extends ConsumerWidget {
  const _NameInput({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Team name',
      ),
      onChanged: (value) {
        // ref.read(nameProvider.notifier).state = value;
      },
    );
  }
}

class _AddTeamButton extends ConsumerWidget {
  const _AddTeamButton({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        final name = value.text;
        return ElevatedButton(
          onPressed: name.isEmpty
              ? null
              : () {
                  final team = Team(
                    name: name,
                    userCount: 0,
                    createdAt: DateTime.now(),
                    createdAtFieldValue: FieldValue.serverTimestamp(),
                    labels: [
                      'New',
                      'Agile',
                      'Innovative',
                      'Collaborative',
                    ],
                  );
                  ref.read(firestoreQueryServiceProvider).addTeam(team: team);
                  controller.clear();
                },
          child: const Text('Add'),
        );
      },
    );
  }
}

class _TeamList extends ConsumerWidget {
  const _TeamList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamList = ref.watch(teamCollectionProvider);
    if (teamList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (teamList.isEmpty) {
      return const Text('No team in database. Add some teams.');
    }

    return ListView.separated(
      itemCount: teamList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final team = teamList[index];
        return _TeamItem(
          team: team,
        );
      },
    );
  }
}

class _TeamItem extends ConsumerWidget {
  const _TeamItem({
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamId = team.teamId;
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
                teamId: teamId,
              );
        },
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => TeamDetailsPage(teamId: teamId),
          ),
        );
      },
    );
  }
}
