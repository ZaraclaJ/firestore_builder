import 'package:firestore_builder_devtools_extension/home_layout.dart';
import 'package:firestore_builder_devtools_extension/theme/responsive_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveTheme(
      child: MaterialApp(
        home: Scaffold(
          body: HomeLayout(),
        ),
      ),
    );
  }
}
