import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';

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

extension LibraryDartFormatterExtensions on Library {
  @UseResult()
  String toDart() {
    final dartEmitter = DartEmitter(
      allocator: _SimpleAllocator(),
      orderDirectives: true,
      useNullSafetySyntax: true,
    );
    final stringCode = accept(dartEmitter).toString();

    final dartFormatter = DartFormatter();
    return dartFormatter.format(stringCode);
  }
}
