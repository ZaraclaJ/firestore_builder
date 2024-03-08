import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/extensions.dart/dart_formatter_extensions.dart';
import 'package:firestore_builder/src/helpers/logger.dart';

Future<void> generateLibrary({
  required Library library,
  required String filePath,
}) async {
  final dartLibrary = library.toDart();
  final file = File(filePath);
  await file.create(recursive: true);
  await file.writeAsString(dartLibrary);
  Logger.log('✔︎ $filePath generated');
}
