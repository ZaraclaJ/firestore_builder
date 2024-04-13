import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/collections/collections_bloc.dart';
import 'package:firestore_builder_devtools_extension/theme/responsive_theme.dart';
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
    return const ResponsiveTheme(
      child: _Layout(),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Home Page'),
        Expanded(
          child: CollectionsBloc(),
        ),
      ],
    );
  }
}
