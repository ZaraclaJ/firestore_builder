import 'package:example/constants/users.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/message_states.dart';
import 'package:example/firestore/states/team_states.dart';
import 'package:example/firestore/states/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamDetailsPage extends StatelessWidget {
  const TeamDetailsPage({
    required this.teamId,
    super.key,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Team Details'),
        ),
        floatingActionButton: _AddButton(
          teamId: teamId,
        ),
        body: _Layout(
          teamId: teamId,
        ),
      ),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final team = ref.watch(teamProvider(teamId));
    if (team == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Id : ${teamId.value}'),
          Text('Name : ${team.name}'),
          Text('Description : ${team.description}'),
          Expanded(
            child: _TabBarView(
              teamId: teamId,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBarView extends StatelessWidget {
  const _TabBarView({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TabBar(
          tabs: [
            Tab(
              text: 'Users',
            ),
            Tab(
              text: 'Messages',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              _UsersTab(
                teamId: teamId,
              ),
              _MessagesTab(
                teamId: teamId,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UsersTab extends ConsumerStatefulWidget {
  const _UsersTab({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  ConsumerState<_UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends ConsumerState<_UsersTab> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(firestoreQueryServiceProvider);

    final users = ref.watch(userCollectionProvider(widget.teamId));
    return Column(
      children: [
        RangeSlider(
          values: _currentRangeValues,
          max: 100,
          divisions: 100,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        Expanded(
          child: FutureBuilder(
            future: service.getUsersCollectionWhere(
              teamId: widget.teamId,
              where: (ref) {
                return ref.where(
                  'age',
                  isGreaterThan: _currentRangeValues.start.round(),
                  isLessThan: _currentRangeValues.end.round(),
                );
              },
            ),
            builder: (context, snapshot) {
              final users = snapshot.data;
              if (users == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                itemCount: users.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.age.toString()),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MessagesTab extends ConsumerWidget {
  const _MessagesTab({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageCollectionProvider(teamId));
    if (messages == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.separated(
      itemCount: messages.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          title: Text(message.content),
          subtitle: Text(message.date.toString()),
        );
      },
    );
  }
}

class _AddButton extends ConsumerWidget {
  const _AddButton({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = DefaultTabController.of(context);
    return ListenableBuilder(
      listenable: tabController,
      builder: (context, child) {
        final index = tabController.index;
        return FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: index == 0 ? const Text('Add User') : const Text('Add Message'),
          onPressed: () async {
            if (index == 0) {
              // Add user
              final user = getRandomUser();
              final service = ref.watch(firestoreQueryServiceProvider);
              await service.addUser(teamId: teamId, user: user);
            } else {
              // Add message
            }
          },
        );
      },
    );
  }
}
