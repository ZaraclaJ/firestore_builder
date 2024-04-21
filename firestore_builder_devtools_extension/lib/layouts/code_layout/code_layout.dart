import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/extensions/num_extensions.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight/languages/yaml.dart';

final codeErrorProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

class CodeLayout extends StatelessWidget {
  const CodeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.bounded(codeLayoutMinWidth, double.infinity);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: width,
            child: const AppPadding.regular(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _Code(),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: _ErrorBanner(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ErrorBanner extends ConsumerWidget {
  const _ErrorBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final error = ref.watch(codeErrorProvider);
    if (error == null) {
      return const SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.error.withOpacity(0.4),
        borderRadius: defaultBorderRadius,
      ),
      constraints: const BoxConstraints(maxHeight: 100),
      child: SingleChildScrollView(
        child: AppPadding.regular(
          child: Text(
            error,
            style: context.typos.bodyMedium?.copyWith(color: context.theme.colorScheme.onError),
          ),
        ),
      ),
    );
  }
}

class _Code extends ConsumerWidget {
  const _Code();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = codeTheme.backgroundColor;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: context.theme.dividerColor),
        borderRadius: defaultBorderRadius,
      ),
      child: const SingleChildScrollView(
        child: AppPadding.semiBig(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _CodeWithCodeEditor(),
          ),
        ),
      ),
    );
  }
}

class _CodeWithCodeEditor extends ConsumerStatefulWidget {
  const _CodeWithCodeEditor();

  @override
  ConsumerState<_CodeWithCodeEditor> createState() => _CodeWithCodeEditorState();
}

class _CodeWithCodeEditorState extends ConsumerState<_CodeWithCodeEditor> {
  late CodeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      language: yaml,
      text: ref.read(codeProvider),
    );
  }

  void _updateCode(String newCode) {
    final currentSelection = _controller.selection;
    _controller
      // Fix issue with bad text update
      ..clear()
      ..text = newCode
      ..selection = currentSelection;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      codeProvider,
      (previous, newCode) {
        if (previous != newCode && newCode != _controller.fullText) {
          _updateCode(newCode);
        }
      },
    );
    return CodeTheme(
      data: CodeThemeData(styles: codeTheme),
      child: CodeField(
        onChanged: (newCode) {
          ref.read(configViewModelProvider).updateYamlCode(newCode);
        },
        controller: _controller,
        textStyle: context.typos.bodySmall,
      ),
    );
  }
}

extension on Map<String, TextStyle> {
  Color get backgroundColor {
    final theme = this;
    return theme['root']!.backgroundColor!;
  }
}
