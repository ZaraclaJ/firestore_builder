import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter/material.dart';

const YamlConfig config = YamlConfig(
  clear: false,
  projectName: 'example',
  collections: [],
  outputPath: 'lib/api',
);

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Home Page');
  }
}
