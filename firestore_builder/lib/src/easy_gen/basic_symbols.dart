abstract class BasicSymbols {
  /// 'T'
  static const String generic = 'T';

  /// 'void'
  static const String void$ = 'void';

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

  /// 'Future'
  static const String future = 'Future';

  /// 'Stream'
  static const String stream = 'Stream';

  /// 'List'
  static const String list = 'List';

  /// 'Map'
  static const String map = 'Map';

  /// Map<String, Object?>
  static const String json = 'Map<String, Object?>';

  /// 'Timestamp'
  static const String timestamp = 'Timestamp';

  /// 'map'
  static const String toListMethod = 'toList';

  /// 'toList'
  static const String mapMethod = 'map';

  /// 'isEmpty'
  static const String isEmptyGetter = 'isEmpty';

  /// 'isEmpty'
  static const String isNotEmptyGetter = 'isNotEmpty';
}

abstract class FirestoreSymbols {
  /// 'FieldValue'
  static const String fieldValueClass = 'FieldValue';

  /// 'Query'
  static const String queryClass = 'Query';

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

  /// 'docs'
  static const String docsProperty = 'docs';

  /// 'id'
  static const String idProperty = 'id';

  /// 'collection'
  static const String collectionMethod = 'collection';

  /// 'get'
  static const String getMethod = 'get';

  /// 'add'
  static const String addMethod = 'add';

  /// 'add'
  static const String setMethod = 'set';

  /// 'update'
  static const String updateMethod = 'update';

  /// 'delete'
  static const String deleteMethod = 'delete';

  /// 'delete'
  static const String whereMethod = 'where';

  /// 'doc'
  static const String docMethod = 'doc';

  /// 'data'
  static const String dataMethod = 'data';

  /// 'snapshots'
  static const String snapshotsMethod = 'snapshots';

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

  /// 'DateTimeConverter'
  static const String dateTimeConverter = 'DateTimeConverter';

  /// 'TimestampConverter'
  static const String timestampConverter = 'TimestampConverter';

  /// 'JsonConverter'
  static const String jsonConverter = 'JsonConverter';
}

abstract class RiverpodSymbols {
  /// 'Provider'
  static const String providerClass = 'Provider';

  /// 'StreamProvider'
  static const String streamProviderClass = 'StreamProvider';

  /// 'autoDispose'
  static const String autoDispose = 'autoDispose';

  /// 'family'
  static const String family = 'family';

  /// 'watch'
  static const String watchMethod = 'watch';
}

abstract class UpdatedValueSymbols {
  /// 'UpdatedValue'
  static const String updatedValueClass = 'UpdatedValue';

  /// 'value'
  static const String valueProperty = 'value';
}
