import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/extensions.dart/dart_formatter_extensions.dart';

class GeneratedFile {
  GeneratedFile({
    required Library library,
    required this.filePath,
  }) : content = library.toDart();

  final String content;
  final String filePath;
}
