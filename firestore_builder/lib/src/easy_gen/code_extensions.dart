import 'package:code_builder/code_builder.dart';

extension CodeExtensions on Code {
  Block ifBlock(Code condition, {bool withBrackets = true}) {
    return Block.of([
      const Code('if('),
      condition,
      const Code(')'),
      if (withBrackets) const Code('{'),
      this,
      if (withBrackets) const Code('}'),
    ]);
  }
}
