import 'package:example/firebase_options.dart';
import 'package:example/firestore/models/user.dart';
import 'package:example/firestore/services/firestore_query_service.dart';
import 'package:example/firestore/states/user_states.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);

final ageProvider = StateProvider.autoDispose<int>(
  (ref) => 18,
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
              padding: EdgeInsets.all(16),
              child: AgeInput(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: AddUserButton(),
            ),
            Expanded(
              child: UserList(),
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
        labelText: 'User name',
      ),
      onChanged: (value) {
        ref.read(nameProvider.notifier).state = value;
      },
    );
  }
}

class AgeInput extends ConsumerWidget {
  const AgeInput({
    this.min = 18,
    this.max = 50,
    super.key,
  });

  final int min;
  final int max;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final age = ref.watch(ageProvider);
    return Row(
      children: [
        const Text('Age:'),
        Text(age.toString()),
        Expanded(
          child: Slider(
            value: age.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: 100,
            label: age.toString(),
            onChanged: (value) {
              ref.read(ageProvider.notifier).state = value.toInt();
            },
          ),
        ),
      ],
    );
  }
}

class AddUserButton extends ConsumerWidget {
  const AddUserButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: ref.watch(nameProvider.select((value) => value.isEmpty))
          ? null
          : () {
              final name = ref.read(nameProvider);
              final age = ref.read(ageProvider);
              final user = User(
                name: name,
                age: age,
              );
              ref.read(firestoreQueryServiceProvider).addUser(user);
              ref.invalidate(firestoreQueryServiceProvider);
            },
      child: const Text('Add'),
    );
  }
}

class UserList extends ConsumerWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.watch(userCollectionProvider);
    if (userList == null) {
      return const CircularProgressIndicator();
    }

    if (userList.isEmpty) {
      return const Text('No users in database. Add some users.');
    }

    return ListView.separated(
      itemCount: userList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final user = userList[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.age.toString()),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              ref.read(firestoreQueryServiceProvider).deleteUser(user.userId);
            },
          ),
        );
      },
    );
  }
}
