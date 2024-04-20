import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
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

  String? extractListType() {
    return _extractType(BasicSymbols.list);
  }

  String? extractMapType() {
    return _extractType(BasicSymbols.map);
  }

  String? _extractType(String prefix) {
    final regex = RegExp('^$prefix<(.*?)>\$');
    final match = regex.firstMatch(this);
    if (match == null) {
      return null;
    }

    final typesString = substring(match.start + 1 + prefix.length, match.end - 1);
    final types = typesString.split(',').map((e) => e.trim());
    if (types.length != 2 || types.first != BasicSymbols.string) {
      return null;
    }

    return types.elementAt(1);
  }
}

extension TypeExtensions on String {
  bool get isNullable => endsWith(_nullableSuffix);
}
