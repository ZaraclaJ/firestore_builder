import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';

abstract class BasicTypes {
  /// 'String'
  static const Reference string = Reference(BasicSymbols.string);

  /// 'int'
  static const Reference int = Reference(BasicSymbols.int);

  /// 'double'
  static const Reference double = Reference(BasicSymbols.double);

  /// 'bool'
  static const Reference bool = Reference(BasicSymbols.bool);

  /// 'DateTime'
  static const Reference dateTime = Reference(BasicSymbols.dateTime);

  /// 'Timestamp'
  static const Reference timestamp = Reference(
    BasicSymbols.timestamp,
    BasicPackages.cloudFirestore,
  );
}
