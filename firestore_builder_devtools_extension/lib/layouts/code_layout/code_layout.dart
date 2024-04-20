import 'package:devtools_app_shared/ui.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/double_scroll_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeLayout extends StatelessWidget {
  const CodeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPadding.regular(
      child: _Code(),
    );
  }
}

class _Code extends ConsumerWidget {
  const _Code();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(codeProvider);
    final backgroundColor = codeTheme.backgroundColor;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: context.theme.dividerColor),
        borderRadius: defaultBorderRadius,
      ),
      child: DoubleScrollLayout(
        child: AppPadding.semiBig(
          child: Align(
            alignment: Alignment.centerLeft,
            child: HighlightView(
              code,
              language: 'yaml',
              theme: codeTheme,
              textStyle: TextStyle(fontSize: context.typos.bodyMedium?.fontSize),
            ),
          ),
        ),
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
