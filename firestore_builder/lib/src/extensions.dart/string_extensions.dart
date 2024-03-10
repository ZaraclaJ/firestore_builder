import 'package:recase/recase.dart';

const String _nullableSuffix = '?';
const String _underscorePrefix = '_';

extension StringExtensions on String {
  String withoutSuffix(String suffix) {
    return endsWith(suffix) ? substring(0, length - suffix.length) : this;
  }

  String withoutPrefix(String prefix) {
    return startsWith(prefix) ? substring(prefix.length) : this;
  }

  String get withoutQuestionMark => withoutSuffix(_nullableSuffix);

  String get withoutUnderscore => withoutPrefix(_underscorePrefix);

  String get publicName => camelCase.withoutUnderscore;
  String get privateName => '$_underscorePrefix$camelCase';

  String toPackageUrl({required String projectName}) {
    final filePath = withoutPrefix('lib/');
    return 'package:$projectName/$filePath';
  }
}

extension TypeExtensions on String {
  bool get isNullable => endsWith(_nullableSuffix);
}
