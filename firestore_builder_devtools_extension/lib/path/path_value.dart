import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/path/path_builder.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/widgets/section_text.dart';
import 'package:flutter/material.dart';

class PathValue extends StatelessWidget {
  const PathValue({
    required this.collection,
    super.key,
  });

  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    return PathBuilder(
      collection: collection,
      builder: (path) {
        return SectionText(
          path,
          color: context.colors.primary,
        );
      },
    );
  }
}
