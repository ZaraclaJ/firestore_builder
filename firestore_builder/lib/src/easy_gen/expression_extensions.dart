import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';

extension ReferenceExtensions on Reference {
  Reference get nullSafe => Reference('$symbol?', url);
}

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

  Expression toList() {
    return method(BasicSymbols.toListMethod);
  }

  Expression map({
    required List<String> parameters,
    required Code body,
    bool lambda = true,
  }) {
    final expression = this;
    return expression.method(BasicSymbols.mapMethod, [
      Expressions.lambdaMethod(
        lambda: lambda,
        parameters: parameters,
        body: body,
      ),
    ]);
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

class NullableReference extends Reference {
  NullableReference(
    Reference reference,
  ) : super('${reference.symbol}?', reference.url);
}
