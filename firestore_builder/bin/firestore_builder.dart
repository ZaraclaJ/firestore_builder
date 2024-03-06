// ignore_for_file: avoid_print

import 'package:firestore_builder/src/generators.dart';

void main(List<String> args) {
  final filePath = args.firstOrNull;
  generate(path: filePath);
}
