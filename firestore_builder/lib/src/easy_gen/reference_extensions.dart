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

  String? get symbolName => symbol;
}

extension TypeReferenceExtensions on TypeReference {
  String get symbolName {
    final symbol = this.symbol;
    return [
      symbol,
      ...types.map((t) => t.symbolName),
    ].join();
  }
}
