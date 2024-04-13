import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter/material.dart';

const YamlConfig config = YamlConfig(
  clear: false,
  projectName: 'example',
  collections: [],
  outputPath: 'lib/api',
);

void main() {
  runApp(
    const DevToolsExtension(
      child: FooDevToolsExtension(),
    ),
  );
}

class FooDevToolsExtension extends StatelessWidget {
  const FooDevToolsExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
