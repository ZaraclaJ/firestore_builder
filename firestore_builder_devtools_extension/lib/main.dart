import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder_devtools_extension/home_layout.dart';
import 'package:firestore_builder_devtools_extension/theme/responsive_theme.dart';
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
    return const ResponsiveTheme(
      child: DevToolsExtension(
        child: HomeLayout(),
      ),
    );
  }
}
