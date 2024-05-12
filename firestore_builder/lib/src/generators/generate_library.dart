import 'dart:io';

import 'package:firestore_builder/src/helpers/logger.dart';
import 'package:firestore_builder/src/models/generated_file.dart';

extension GeneratedFileExtensions on GeneratedFile {
  Future<void> generate() async {
    final file = File(filePath);
    await file.create(recursive: true);
    await file.writeAsString(content);
    Logger.log('✔︎ $filePath generated');
  }
}
