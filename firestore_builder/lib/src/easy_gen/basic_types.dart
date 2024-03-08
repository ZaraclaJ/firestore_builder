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

  /// Map<String, Object?>
  static Reference json = const Reference(BasicSymbols.json);

  /// 'Timestamp'
  static const Reference timestamp = Reference(
    BasicSymbols.timestamp,
    BasicPackages.cloudFirestore,
  );
}

abstract class FirestoreTypes {
  /// FirebaseFirestore
  static Reference firebaseFirestore = const Reference(
    FirestoreSymbols.firebaseFirestore,
    BasicPackages.cloudFirestore,
  );

  /// DocumentSnapshot<ref>
  static TypeReference documentSnapshotOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.documentSnapshot
        ..url = BasicPackages.cloudFirestore
        ..types.add(ref),
    );
  }

  /// SnapshotOptions
  static TypeReference snapshotOptions({bool isNullable = false}) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.snapshotOptions
        ..url = BasicPackages.cloudFirestore
        ..isNullable = isNullable,
    );
  }
}
