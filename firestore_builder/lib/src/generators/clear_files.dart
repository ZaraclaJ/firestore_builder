import 'dart:io';

import 'package:firestore_builder/src/helpers/logger.dart';

Future<void> clearFiles({
  required String path,
}) async {
  final dartFiles = _filesWithExtensions(
    path: path,
    extensions: ['.dart'],
  );
  final futures = dartFiles.map((file) => file.delete());
  await Future.wait(futures);

  Logger.log('✔︎ All files in $path cleared (${dartFiles.length})');
}

Iterable<File> _filesWithExtensions({
  required String path,
  required List<String> extensions,
}) {
  final directory = Directory(path);
  final files = directory.listSync(recursive: true).whereType<File>().where((queryFile) {
    return extensions.any((extension) => queryFile.path.endsWith(extension));
  });
  return files;
}
