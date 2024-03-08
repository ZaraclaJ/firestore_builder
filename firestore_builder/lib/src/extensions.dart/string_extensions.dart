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
}

extension TypeExtensions on String {
  bool get isNullable => endsWith(_nullableSuffix);
}
