import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/copy_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';

class CodeView extends StatelessWidget {
  const CodeView({
    required this.code,
    super.key,
  });

  final String code;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        CodeTheme(
          data: CodeThemeData(styles: codeTheme),
          child: CodeField(
            readOnly: true,
            controller: CodeController(text: code),
            gutterStyle: const GutterStyle(
              margin: 0,
              width: 0,
              showLineNumbers: false,
            ),
          ),
        ),
        AppPadding.regular(
          child: CopyButton(
            text: code,
          ),
        ),
      ],
    );
  }
}
