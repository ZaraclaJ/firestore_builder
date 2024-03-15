import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';

abstract class BasicTypes {
  /// 'void'
  static const Reference void$ = Reference(BasicSymbols.void$);

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

  /// List<ref>
  static TypeReference listOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = BasicSymbols.list
        ..types.add(ref),
    );
  }

  /// Future<ref>
  static TypeReference futureOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = BasicSymbols.future
        ..types.add(ref),
    );
  }

  /// Stream<ref>
  static TypeReference streamOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = BasicSymbols.stream
        ..url = BasicPackages.dartAsync
        ..types.add(ref),
    );
  }

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
    FirestoreSymbols.firebaseFirestoreClass,
    BasicPackages.cloudFirestore,
  );

  /// CollectionReference<ref>
  static TypeReference queryOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.queryClass
        ..url = BasicPackages.cloudFirestore
        ..types.add(ref),
    );
  }

  /// CollectionReference<ref>
  static TypeReference collectionReferenceOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.collectionReferenceClass
        ..url = BasicPackages.cloudFirestore
        ..types.add(ref),
    );
  }

  /// DocumentReference<ref>
  static TypeReference documentReferenceOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.documentReferenceClass
        ..url = BasicPackages.cloudFirestore
        ..types.add(ref),
    );
  }

  /// DocumentSnapshot<ref>
  static TypeReference documentSnapshotOf(Reference ref) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.documentSnapshotClass
        ..url = BasicPackages.cloudFirestore
        ..types.add(ref),
    );
  }

  /// SnapshotOptions
  static TypeReference snapshotOptions({bool isNullable = false}) {
    return TypeReference(
      (type) => type
        ..symbol = FirestoreSymbols.snapshotOptionsClass
        ..url = BasicPackages.cloudFirestore
        ..isNullable = isNullable,
    );
  }
}

abstract class RiverpodTypes {
  /// Provider
  static Reference provider = const Reference(
    RiverpodSymbols.providerClass,
    BasicPackages.flutterRiverpod,
  );

  /// StreamProvider
  static Reference streamProvider = const Reference(
    RiverpodSymbols.streamProviderClass,
    BasicPackages.flutterRiverpod,
  );
}
