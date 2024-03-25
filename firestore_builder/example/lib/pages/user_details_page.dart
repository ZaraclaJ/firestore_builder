import 'package:example/constants/items.dart';
import 'package:example/firestore/models/team.dart';
import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/item_states.dart';
import 'package:example/firestore/states/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({
    required this.teamId,
    required this.userId,
    super.key,
  });

  final TeamId teamId;
  final UserId userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Team Details'),
      ),
      floatingActionButton: _AddButton(
        teamId: teamId,
        userId: userId,
      ),
      body: _Layout(
        teamId: teamId,
        userId: userId,
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout({
    required this.teamId,
    required this.userId,
  });

  final TeamId teamId;
  final UserId userId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserDetails(
            teamId: teamId,
            userId: userId,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Items : ',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Expanded(
            child: _ItemList(
              teamId: teamId,
              userId: userId,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserDetails extends ConsumerWidget {
  const _UserDetails({
    required this.teamId,
    required this.userId,
  });

  final TeamId teamId;
  final UserId userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      userProvider(
        UserPath(userId: userId, teamId: teamId),
      ),
    );
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Id : ${user.userId.value}'),
          Text('Name : ${user.name}'),
          Text('Age : ${user.age}'),
        ],
      ),
    );
  }
}

class _ItemList extends ConsumerWidget {
  const _ItemList({
    required this.teamId,
    required this.userId,
  });

  final TeamId teamId;
  final UserId userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(
      itemCollectionProvider(
        UserPath(userId: userId, teamId: teamId),
      ),
    );

    if (items == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (items.isEmpty) {
      return const Center(
        child: Text('No items'),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.name),
        );
      },
    );
  }
}

class _AddButton extends ConsumerWidget {
  const _AddButton({
    required this.teamId,
    required this.userId,
  });

  final TeamId teamId;
  final UserId userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final service = ref.read(firestoreQueryServiceProvider);
        final item = getRandomItem();
        await service.addItem(
          teamId: teamId,
          userId: userId,
          item: item,
        );
      },
      label: const Text('Add item'),
      icon: const Icon(Icons.add),
    );
  }
}
