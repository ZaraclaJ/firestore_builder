import 'package:firestore_builder_devtools_extension/extensions/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('Testing isOnlyLetters method', () {
    test('valid input string', () {
      expect('HelloWorld'.isOnlyLetters, true);
    });

    test('invalid input string', () {
      expect('Hello World'.isOnlyLetters, false);
    });

    test('empty input string', () {
      expect(''.isOnlyLetters, false);
    });

    test('special characters input string', () {
      expect('Hello-World'.isOnlyLetters, false);
    });

    test('numbers input string', () {
      expect('Hello123World'.isOnlyLetters, false);
    });

    test('underscore input string', () {
      expect('Hello_World'.isOnlyLetters, true);
    });

    test('underscore and numbers input string', () {
      expect('Hello_123_World'.isOnlyLetters, false);
    });
  });
}
