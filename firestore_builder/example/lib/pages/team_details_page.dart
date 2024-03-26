import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/constants/labels.dart';
import 'package:example/constants/messages.dart';
import 'package:example/constants/users.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/message_states.dart';
import 'package:example/firestore/states/team_states.dart';
import 'package:example/pages/user_details_page.dart';
import 'package:example/widgets/edit_dialog.dart';
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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TeamDetails(
            teamId: teamId,
          ),
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

class _TeamDetails extends ConsumerWidget {
  const _TeamDetails({
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

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Id : ${teamId.value}'),
          Text('Name : ${team.name}'),
          Row(
            children: [
              Text('Description : ${team.description}'),
              IconButton(
                onPressed: () async {
                  await EditDialog.show(
                    context: context,
                    title: 'Edit Description',
                    initialText: team.description ?? '',
                    onValidate: (value) async {
                      final service = ref.read(firestoreQueryServiceProvider);
                      await service.updateTeam(
                        teamId: teamId,
                        description: UpdatedValue(value),
                      );
                    },
                  );
                },
                iconSize: 16,
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            spacing: 8,
            children: [
              const Text('Labels :'),
              ...team.labels.map(
                (label) => _LabelChip(
                  label: label,
                  teamId: teamId,
                ),
              ),
              // Add chip
              _AddLabelChip(
                teamId: teamId,
              ),
              _ClearAllLabelsChip(
                teamId: teamId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddLabelChip extends ConsumerWidget {
  const _AddLabelChip({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      label: const Text('Add'),
      avatar: const Icon(Icons.add),
      onPressed: () async {
        final service = ref.read(firestoreQueryServiceProvider);
        final label = getRandomLabel();
        await service.updateTeam(
          teamId: teamId,
          labelsFieldValue: UpdatedValue(FieldValue.arrayUnion([label])),
        );
      },
    );
  }
}

class _ClearAllLabelsChip extends ConsumerWidget {
  const _ClearAllLabelsChip({
    required this.teamId,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      label: const Text('Clear All'),
      avatar: const Icon(
        Icons.clear_all,
      ),
      onPressed: () async {
        final service = ref.read(firestoreQueryServiceProvider);
        await service.updateTeam(
          teamId: teamId,
          labels: const UpdatedValue([]),
        );
      },
    );
  }
}

class _LabelChip extends ConsumerWidget {
  const _LabelChip({
    required this.teamId,
    required this.label,
  });

  final TeamId teamId;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Chip(
      label: Text(label),
      onDeleted: () async {
        final service = ref.read(firestoreQueryServiceProvider);
        await service.updateTeam(
          teamId: teamId,
          labelsFieldValue: UpdatedValue(FieldValue.arrayRemove([label])),
        );
      },
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
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => UserDetailsPage(
                            teamId: widget.teamId,
                            userId: user.userId,
                          ),
                        ),
                      );
                    },
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
            final service = ref.watch(firestoreQueryServiceProvider);
            if (index == 0) {
              // Add user
              final user = getRandomUser();
              await service.addUser(teamId: teamId, user: user);
            } else {
              // Add message
              final message = getRandomMessage();
              await service.addMessage(teamId: teamId, message: message);
            }
          },
        );
      },
    );
  }
}
