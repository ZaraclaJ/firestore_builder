import 'package:example/firestore/models/team.dart';
import 'package:flutter/material.dart';

class TeamDetailsPage extends StatelessWidget {
  const TeamDetailsPage({
    required this.teamId,
    super.key,
  });

  final TeamId teamId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Team Details'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Team Details'),
          ],
        ),
      ),
    );
  }
}
