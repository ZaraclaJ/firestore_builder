import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/dialogs/save_dialog.dart';
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
        child: _Layout(),
      ),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ConfigInitializer(
      child: HomeLayout(
        onSaveConfig: () async {
          final confirm = await SaveDialog.show(context);
          if (confirm ?? false) {
            final fileService = ref.read(fileServiceProvider);
            final config = ref.read(configProvider);
            await fileService.saveYamlConfig(config);
          }
        },
      ),
    );
  }
}

class _ConfigInitializer extends ConsumerStatefulWidget {
  const _ConfigInitializer({
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<_ConfigInitializer> createState() => _ConfigBuilderState();
}

class _ConfigBuilderState extends ConsumerState<_ConfigInitializer> {
  bool _isConfigLoaded = false;

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  Future<void> _initConfig() async {
    final success = await _fetchConfig();
    if (!success) {
      await _fetchProjectName();
    }

    setState(() {
      _isConfigLoaded = true;
    });
  }

  Future<bool> _fetchConfig() async {
    final fileService = ref.read(fileServiceProvider);
    final config = await fileService.getCurrentYamlConfig();
    if (config != null) {
      ref.read(configProvider.notifier).state = config;
      return true;
    }
    return false;
  }

  Future<void> _fetchProjectName() async {
    final fileService = ref.read(fileServiceProvider);
    final projectName = await fileService.getProjectName();
    if (projectName != null) {
      ref.read(configProvider.notifier).update(
            (config) => config.copyWith(projectName: projectName),
          );
    }
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
