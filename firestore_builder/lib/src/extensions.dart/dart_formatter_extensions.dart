import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

extension LibraryDartFormatterExtensions on Library {
  @UseResult()
  String toDart() {
    final emitter = _CustomEmitter();
    final stringCode = accept(emitter).toString();

    final dartFormatter = DartFormatter();
    return dartFormatter.format(stringCode);
  }
}

class _CustomEmitter extends DartEmitter {
  _CustomEmitter()
      : super(
          allocator: _SimpleAllocator(),
          orderDirectives: true,
          useNullSafetySyntax: true,
        );

  final int _maxExpressionLength = 75;

  static bool _isLambdaBody(Code? code) => code is ToCodeExpression && !code.isStatement;

  /// Whether the provided [constructor] is considered a lambda method.
  static bool _isLambdaConstructor(Constructor constructor) =>
      constructor.lambda ?? constructor.factory && _isLambdaBody(constructor.body);

  @override
  StringSink visitConstructor(
    Constructor spec,
    String clazz, [
    StringSink? output,
  ]) {
    output ??= StringBuffer();
    spec.docs.forEach(output.writeln);
    for (final a in spec.annotations) {
      visitAnnotation(a, output);
    }
    if (spec.external) {
      output.write('external ');
    }
    if (spec.constant) {
      output.write('const ');
    }
    if (spec.factory) {
      output.write('factory ');
    }
    output.write(clazz);
    if (spec.name != null) {
      output
        ..write('.')
        ..write(spec.name);
    }
    output.write('(');
    if (spec.requiredParameters.isNotEmpty) {
      for (final p in spec.requiredParameters) {
        _visitParameter(p, output);
        output.write(', ');
      }
    }
    if (spec.optionalParameters.isNotEmpty) {
      final named = spec.optionalParameters.any((p) => p.named);
      if (named) {
        output.write('{');
      } else {
        output.write('[');
      }
      for (final p in spec.optionalParameters) {
        _visitParameter(p, output, optional: true, named: named);
        output.write(', ');
      }
      if (named) {
        output.write('}');
      } else {
        output.write(']');
      }
    }
    output.write(')');
    if (spec.initializers.isNotEmpty) {
      output.write(' : ');
      var count = 0;
      for (final initializer in spec.initializers) {
        count++;
        initializer.accept(this, output);
        if (count != spec.initializers.length) {
          output.write(', ');
        }
      }
    }
    if (spec.redirect != null) {
      output.write(' = ');
      spec.redirect!.type.accept(this, output);
      output.write(';');
    } else if (spec.body != null) {
      if (_isLambdaConstructor(spec)) {
        output.write(' => ');
        spec.body!.accept(this, output);
        output.write(';');
      } else {
        output.write(' { ');
        spec.body!.accept(this, output);
        output.write(' }');
      }
    } else {
      output.write(';');
    }
    output.writeln();
    return output;
  }

  // Expose as a first-class visit function only if needed.
  void _visitParameter(
    Parameter spec,
    StringSink output, {
    bool optional = false,
    bool named = false,
  }) {
    spec.docs.forEach(output.writeln);
    for (final a in spec.annotations) {
      visitAnnotation(a, output);
    }
    // The `required` keyword must precede the `covariant` keyword.
    if (spec.required) {
      output.write('required ');
    }
    if (spec.covariant) {
      output.write('covariant ');
    }
    if (spec.type != null) {
      spec.type!.type.accept(this, output);
      output.write(' ');
    }
    if (spec.toThis) {
      output.write('this.');
    }
    if (spec.toSuper) {
      output.write('super.');
    }
    output.write(spec.name);
    if (optional && spec.defaultTo != null) {
      output.write(' = ');
      spec.defaultTo!.accept(this, output);
    }
  }

  @override
  StringSink visitInvokeExpression(InvokeExpression expression, [StringSink? output]) {
    final out = output ??= StringBuffer();
    return _writeConstExpression(out, expression.isConst, () {
      final expressionOut = StringBuffer();
      expression.target.accept(this, expressionOut);
      if (expression.name != null) {
        expressionOut
          ..write('.')
          ..write(expression.name);
      }
      if (expression.typeArguments.isNotEmpty) {
        expressionOut.write('<');
        visitAll<Reference>(expression.typeArguments, expressionOut, (type) {
          type.accept(this, expressionOut);
        });
        expressionOut.write('>');
      }
      expressionOut.write('(');
      visitAll<Spec>(expression.positionalArguments, expressionOut, (spec) {
        spec.accept(this, expressionOut);
      });
      if (expression.positionalArguments.isNotEmpty && expression.namedArguments.isNotEmpty) {
        expressionOut.write(', ');
      }
      visitAll<String>(expression.namedArguments.keys, expressionOut, (name) {
        expressionOut
          ..write(name)
          ..write(': ');
        expression.namedArguments[name]!.accept(this, expressionOut);
      });
      final argumentCount = expression.positionalArguments.length + expression.namedArguments.length;
      if (argumentCount > 1) {
        expressionOut.write(', ');
      }
      if (argumentCount == 1 && expressionOut.toString().length > _maxExpressionLength) {
        expressionOut.write(', ');
      }
      expressionOut.write(')');
      out.write(expressionOut);
      return out;
    });
  }

  @override
  StringSink visitBinaryExpression(
    BinaryExpression expression, [
    StringSink? output,
  ]) {
    output ??= StringBuffer();
    expression.left.accept(this, output);
    if (expression.addSpace) {
      output.write(' ');
    }
    output.write(expression.operator);
    if (expression.addSpace) {
      output.write(' ');
    }
    startConstCode(expression.isConst, () {
      expression.right.accept(this, output);
    });
    return output;
  }

  bool _withInConstExpression = false;

  /// Executes [visit] within a context which may alter the output if [isConst]
  /// is `true`.
  ///
  /// This allows constant expressions to omit the `const` keyword if they
  /// are already within a constant expression.
  @override
  void startConstCode(
    bool isConst,
    Null Function() visit,
  ) {
    final previousConstContext = _withInConstExpression;
    if (isConst) {
      _withInConstExpression = true;
    }

    visit();
    _withInConstExpression = previousConstContext;
  }

  /// Similar to [startConstCode], but handles writing `"const "` if [isConst]
  /// is `true` and the invocation is not nested under other invocations where
  /// [isConst] is true.
  StringSink _writeConstExpression(
    StringSink sink,
    bool isConst,
    StringSink Function() visitExpression,
  ) {
    final previousConstContext = _withInConstExpression;
    if (isConst) {
      if (!_withInConstExpression) {
        sink.write('const ');
      }
      _withInConstExpression = true;
    }

    final returnedSink = visitExpression();
    assert(identical(returnedSink, sink));
    _withInConstExpression = previousConstContext;
    return sink;
  }

  /// Helper method improving on [StringSink.writeAll].
  ///
  /// For every `Spec` in [elements], executing [visit].
  ///
  /// If [elements] is at least 2 elements, inserts [separator] delimiting them.
  StringSink visitAll<T>(
    Iterable<T> elements,
    StringSink output,
    void Function(T) visit, [
    String separator = ', ',
  ]) {
    // Basically, this whole method is an improvement on
    //   output.writeAll(specs.map((s) => s.accept(visitor));
    //
    // ... which would allocate more StringBuffer(s) for a one-time use.
    if (elements.isEmpty) {
      return output;
    }
    final iterator = elements.iterator..moveNext();
    visit(iterator.current);
    while (iterator.moveNext()) {
      output.write(separator);
      visit(iterator.current);
    }
    return output;
  }
}

class _SimpleAllocator implements Allocator {
  _SimpleAllocator();

  final _imports = <String>{};

  @override
  String allocate(Reference reference) {
    final url = reference.url;
    if (url != null) {
      _imports.add(url);
    }
    return reference.symbol!;
  }

  @override
  Iterable<Directive> get imports => _imports.map(Directive.import);
}
