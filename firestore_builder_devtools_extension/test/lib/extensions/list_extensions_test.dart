import 'package:firestore_builder_devtools_extension/extensions/list_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('Testing addOrReplaceWhere', () {
    test('add an element', () {
      expect(
        [1, 2, 3].addOrReplaceWhere(
          where: (element) => false,
          replace: (element) => 4,
        ),
        [1, 2, 3, 4],
      );
    });

    test('replace an element', () {
      expect(
        [1, 2, 3].addOrReplaceWhere(
          where: (element) => element == 2,
          replace: (element) => 4,
        ),
        [1, 4, 3],
      );
    });

    test('replace based on current element', () {
      expect(
        [1, 2, 3].addOrReplaceWhere(
          where: (element) => element == 2,
          replace: (element) => (element ?? 0) + 2,
        ),
        [1, 4, 3],
      );
    });

    test('add if condition not met', () {
      expect(
        [1, 2, 3].addOrReplaceWhere(
          where: (element) => element == 5,
          replace: (element) => 4,
        ),
        [1, 2, 3, 4],
      );
    });

    test('handle empty list', () {
      expect(
        <int>[].addOrReplaceWhere(
          where: (element) => true,
          replace: (element) => 1,
        ),
        [1],
      );
    });
  });
}
