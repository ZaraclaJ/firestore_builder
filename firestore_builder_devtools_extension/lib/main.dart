import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder_devtools_extension/home_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Extension(),
  );
}

class Extension extends StatelessWidget {
  const Extension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: HomeLayout(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: HomeLayout(),
      ),
    );
  }
}
