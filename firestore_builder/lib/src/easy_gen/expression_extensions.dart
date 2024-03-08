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

abstract class Expressions {
  static Expression lambdaMethod({
    required List<String> parameters,
    required Code body,
    List<Parameter> namedParameters = const [],
    bool lambda = true,
    bool async = false,
  }) {
    return Method((m) {
      m
        ..requiredParameters.addAll(
          parameters.map((parameterName) => Parameter((p) => p.name = parameterName)),
        )
        ..optionalParameters.addAll(namedParameters)
        ..lambda = lambda
        ..modifier = async ? MethodModifier.async : null
        ..body = body;
    }).genericClosure;
  }
}
