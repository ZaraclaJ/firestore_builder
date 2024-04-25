import 'package:collection/collection.dart';

extension ListExtensions<T extends Object> on List<T> {
  List<T> addOrReplaceWhere({
    required bool Function(T element) where,
    required T? Function(T? element) replace,
  }) {
    final index = indexWhere(where);
    if (index == -1) {
      return [...this, replace(null)].whereNotNull().toList();
    }

    //use index
    return mapIndexed((i, e) {
      if (i == index) {
        return replace(e);
      }
      return e;
    }).whereNotNull().toList();
  }
}
