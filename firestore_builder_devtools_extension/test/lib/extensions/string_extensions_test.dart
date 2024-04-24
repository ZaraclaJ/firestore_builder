import 'package:firestore_builder_devtools_extension/extensions/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('Testing isOnlyLettersWithUnderscore method', () {
    test('valid input string', () {
      expect('HelloWorld'.isOnlyLettersWithUnderscore, true);
    });

    test('invalid input string', () {
      expect('Hello World'.isOnlyLettersWithUnderscore, false);
    });

    test('empty input string', () {
      expect(''.isOnlyLettersWithUnderscore, false);
    });

    test('special characters input string', () {
      expect('Hello-World'.isOnlyLettersWithUnderscore, false);
    });

    test('numbers input string', () {
      expect('Hello123World'.isOnlyLettersWithUnderscore, false);
    });

    test('underscore input string', () {
      expect('Hello_World'.isOnlyLettersWithUnderscore, true);
    });

    test('underscore and numbers input string', () {
      expect('Hello_123_World'.isOnlyLettersWithUnderscore, false);
    });
  });
}
