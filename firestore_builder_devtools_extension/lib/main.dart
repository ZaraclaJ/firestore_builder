import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/home_layout.dart';
import 'package:firestore_builder_devtools_extension/services/file_services.dart';
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
    return ResponsiveTheme(
      child: DevToolsExtension(
        child: _ConfigBuilder(
          builder: (data) {
            return HomeLayout(
              initialConfig: data,
            );
          },
        ),
      ),
    );
  }
}

class _ConfigBuilder extends ConsumerStatefulWidget {
  const _ConfigBuilder({required this.builder});

  final Widget Function(YamlConfig? content) builder;

  @override
  ConsumerState<_ConfigBuilder> createState() => _ConfigBuilderState();
}

class _ConfigBuilderState extends ConsumerState<_ConfigBuilder> {
  AsyncValue<YamlConfig?> _config = const AsyncValue.loading();

  @override
  void initState() {
    super.initState();
    _fetchConfig();
  }

  Future<void> _fetchConfig() async {
    final fileService = ref.read(fileServiceProvider);
    await Future<void>.delayed(const Duration(seconds: 2));
    final result = await fileService.readFileAsString('pubspec.yaml');
    setState(() {
      _config = AsyncValue.data(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _config.when(
      data: (content) {
        return widget.builder(content);
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
    );
  }
}
