import 'package:code_builder/code_builder.dart';

extension ReferenceExtensions on Reference {
  Reference get nullSafe {
    final ref = this;
    if (ref is TypeReference) {
      return ref.rebuild((e) {
        return e.isNullable = true;
      });
    }

    return Reference('$symbol?', url);
  }

  Reference get withoutUrl => Reference(symbol);

  String? get symbolName {
    final ref = this;
    if (ref is TypeReference) {
      return ref.symbolName;
    }
    return symbol;
  }
}

extension TypeReferenceExtensions on TypeReference {
  String get symbolName {
    final symbol = this.symbol;
    return [
      symbol,
      if (types.isNotEmpty) '<${types.map((e) => e.symbolName).join(', ')}>',
      if (isNullable ?? false) '?',
    ].join();
  }
}
