import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  test(
    'extractListType',
    () {
      expect('List<Timestamp?>'.extractListType(), 'Timestamp?');
    },
  );
}
