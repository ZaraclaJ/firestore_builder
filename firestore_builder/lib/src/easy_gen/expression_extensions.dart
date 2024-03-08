import 'package:code_builder/code_builder.dart';

extension ExpressionExtensions on Expression {
  Expression method(
    String name, [
    Iterable<Expression> positionalArguments = const [],
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  ]) {
    return property(name).call(
      positionalArguments,
      namedArguments,
      typeArguments,
    );
  }
}
