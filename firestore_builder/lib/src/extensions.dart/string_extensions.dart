const String _nullableSuffix = '?';

extension StringExtensions on String {
  String withoutSuffix(String suffix) {
    return endsWith(suffix) ? substring(0, length - suffix.length) : this;
  }

  String get withoutQuestionMark => withoutSuffix(_nullableSuffix);
}

extension TypeExtensions on String {
  bool get isNullable => endsWith(_nullableSuffix);
}
