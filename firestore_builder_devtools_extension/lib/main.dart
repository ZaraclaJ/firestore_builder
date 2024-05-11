import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder_devtools_extension/home_layout.dart';
import 'package:firestore_builder_devtools_extension/services/file_services.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/responsive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: Extension(),
    ),
  );
}

class Extension extends ConsumerWidget {
  const Extension({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ResponsiveTheme(
      child: DevToolsExtension(
        child: _ConfigBuilder(
          child: HomeLayout(),
        ),
      ),
    );
  }
}

class _ConfigBuilder extends ConsumerStatefulWidget {
  const _ConfigBuilder({required this.child});

  final Widget child;

  @override
  ConsumerState<_ConfigBuilder> createState() => _ConfigBuilderState();
}

class _ConfigBuilderState extends ConsumerState<_ConfigBuilder> {
  bool _isConfigLoaded = false;

  @override
  void initState() {
    super.initState();
    _fetchConfig();
  }

  Future<void> _fetchConfig() async {
    final fileService = ref.read(fileServiceProvider);
    final config = await fileService.getCurrentYamlConfig();
    if (config == null) {
      return;
    }
    ref.read(configProvider.notifier).state = config;

    setState(() {
      _isConfigLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConfigLoaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return widget.child;
  }
}
