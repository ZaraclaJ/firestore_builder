import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';

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
}

extension ExpressionExtensions on Expression {
  Expression method(
    String name, {
    Iterable<Expression> positionalArguments = const [],
    Map<String, Expression> namedArguments = const {},
    List<Reference> typeArguments = const [],
  }) {
    return property(name).call(
      positionalArguments,
      namedArguments,
      typeArguments,
    );
  }

  Expression toList() {
    return method(BasicSymbols.toListMethod);
  }

  Expression get isEmpty {
    return property(BasicSymbols.isEmptyGetter);
  }

  Expression get isNotEmpty {
    return property(BasicSymbols.isNotEmptyGetter);
  }

  Expression map({
    required List<String> parameters,
    required Code body,
    bool lambda = true,
  }) {
    final expression = this;
    return expression.method(
      BasicSymbols.mapMethod,
      positionalArguments: [
        Expressions.lambdaMethod(
          lambda: lambda,
          parameters: parameters,
          body: body,
        ),
      ],
    );
  }
}

extension RiverpodExpressionExtensions on Expression {
  Expression get _autoDispose {
    return property(RiverpodSymbols.autoDispose);
  }

  Expression _autoDisposeMethod({
    required List<String> parameters,
    required Code body,
    required Reference state,
  }) {
    return method(
      RiverpodSymbols.autoDispose,
      positionalArguments: [
        Expressions.lambdaMethod(
          lambda: false,
          parameters: parameters,
          body: body,
        ),
      ],
      typeArguments: [state],
    );
  }

  Expression autoDisposeFamilyMethod({
    required List<String> parameters,
    required Code body,
    required Reference state,
    Reference? arg,
  }) {
    if (arg == null) {
      return _autoDisposeMethod(
        body: body,
        parameters: parameters,
        state: state,
      );
    }

    return _autoDispose.method(
      RiverpodSymbols.family,
      positionalArguments: [
        Expressions.lambdaMethod(
          lambda: false,
          parameters: parameters,
          body: body,
        ),
      ],
      typeArguments: [
        state,
        arg,
      ],
    );
  }

  Expression watch(Expression provider) {
    return method(RiverpodSymbols.watchMethod, positionalArguments: [provider]);
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
