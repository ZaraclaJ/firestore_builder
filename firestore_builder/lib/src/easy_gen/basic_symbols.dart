abstract class BasicSymbols {
  /// 'String'
  static const String string = 'String';

  /// 'int'
  static const String int = 'int';

  /// 'double'
  static const String double = 'double';

  /// 'bool'
  static const String bool = 'bool';

  /// 'DateTime'
  static const String dateTime = 'DateTime';

  /// Map<String, Object?>
  static const String json = 'Map<String, Object?>';

  /// 'Timestamp'
  static const String timestamp = 'Timestamp';
}

abstract class FirestoreSymbols {
  /// 'FirebaseFirestore'
  static const String firebaseFirestoreClass = 'FirebaseFirestore';

  /// 'CollectionReference'
  static const String collectionReferenceClass = 'CollectionReference';

  /// 'DocumentReference'
  static const String documentReferenceClass = 'DocumentReference';

  /// 'DocumentSnapshot'
  static const String documentSnapshotClass = 'DocumentSnapshot';

  /// 'SnapshotOptions'
  static const String snapshotOptionsClass = 'SnapshotOptions';

  /// 'collection'
  static const String collectionMethod = 'collection';

  /// 'doc'
  static const String docMethod = 'doc';

  /// 'withConverter'
  static const String withConverterMethod = 'withConverter';

  /// 'fromFirestore'
  static const String fromFirestoreParam = 'fromFirestore';

  /// 'toFirestore'
  static const String toFirestoreParam = 'toFirestore';
}

abstract class FreezedSymbols {
  /// 'fromJson'
  static const String toJsonMethod = 'toJson';

  /// 'fromJson'
  static const String fromJsonMethod = 'fromJson';

  /// 'copyWith'
  static const String copyWithMethod = 'copyWith';
}
