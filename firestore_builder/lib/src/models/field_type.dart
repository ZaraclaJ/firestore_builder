import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_type.freezed.dart';

@freezed
class FieldType with _$FieldType {
  const factory FieldType.string({
    required bool isNullable,
  }) = FieldTypeString;

  const factory FieldType.int({
    required bool isNullable,
  }) = FieldTypeInt;

  const factory FieldType.double({
    required bool isNullable,
  }) = FieldTypeDouble;

  const factory FieldType.bool({
    required bool isNullable,
  }) = FieldTypeBool;

  const factory FieldType.timestamp({
    required bool isNullable,
  }) = FieldTypeTimestamp;

  const factory FieldType.dateTime({
    required bool isNullable,
  }) = FieldTypeDateTime;

  const factory FieldType.documentReference({
    required bool isNullable,
  }) = FieldTypeDocumentReference;

  const factory FieldType.customClass({
    required String className,
    required String path,
    required bool isNullable,
  }) = FieldTypeCustomClass;

  const factory FieldType.list({
    required FieldType subType,
    required String? path,
    required bool isNullable,
  }) = FieldTypeList;

  const factory FieldType.map({
    required FieldType subType,
    required String? path,
    required bool isNullable,
  }) = FieldTypeMap;

  /// Accepts a Dart symbol and returns the corresponding [FieldType].
  ///
  /// The following symbols are supported:
  /// - `String`
  /// - `int`
  /// - `double`
  /// - `bool`
  /// - `Timestamp`
  /// - `DateTime`
  /// - `DocumentReference`
  /// - `List<T>`
  /// - `Map<T>`
  factory FieldType.fromDartSymbol({
    required String symbol,
    required String? path,
  }) {
    final isNullable = symbol.isNullable;
    final pureType = symbol.withoutQuestionMark;

    return switch (pureType) {
      final a when a.extractListType() != null => FieldType.list(
          subType: FieldType.fromDartSymbol(
            symbol: a.extractListType()!,
            path: path,
          ),
          isNullable: isNullable,
          path: path,
        ),
      final a when a.extractMapType() != null => FieldType.map(
          subType: FieldType.fromDartSymbol(
            symbol: a.extractMapType()!,
            path: path,
          ),
          isNullable: isNullable,
          path: path,
        ),
      BasicSymbols.string => FieldType.string(isNullable: isNullable),
      BasicSymbols.int => FieldType.int(isNullable: isNullable),
      BasicSymbols.double => FieldType.double(isNullable: isNullable),
      BasicSymbols.bool => FieldType.bool(isNullable: isNullable),
      BasicSymbols.dateTime => FieldType.dateTime(isNullable: isNullable),
      BasicSymbols.timestamp => FieldType.timestamp(isNullable: isNullable),
      FirestoreSymbols.documentReferenceClass => FieldType.documentReference(isNullable: isNullable),
      _ when path != null => FieldType.customClass(
          className: pureType,
          isNullable: isNullable,
          path: path,
        ),
      _ => throw Exception('Type $symbol is not recognized'),
    };
  }
}

extension FieldTypeExtensions on FieldType {
  TypeReference get typeReference {
    final type = this;
    return TypeReference(
      (b) => b
        ..symbol = type.dartSymbol
        ..url = type.packageUrl
        ..isNullable = isNullable
        ..types.addAll([
          if (type is FieldTypeList) type.subType.typeReference,
          if (type is FieldTypeMap) ...[
            BasicTypes.string,
            type.subType.typeReference,
          ],
        ]),
    );
  }

  String get dartSymbol {
    return map(
      string: (_) => BasicSymbols.string,
      int: (_) => BasicSymbols.int,
      double: (_) => BasicSymbols.double,
      bool: (_) => BasicSymbols.bool,
      timestamp: (_) => BasicSymbols.timestamp,
      dateTime: (_) => BasicSymbols.dateTime,
      documentReference: (_) => FirestoreSymbols.documentReferenceClass,
      list: (field) => BasicSymbols.list,
      map: (field) => BasicSymbols.map,
      customClass: (field) => field.className,
    );
  }

  String? get packageUrl {
    return switch (this) {
      FieldTypeTimestamp() => BasicPackages.cloudFirestore,
      FieldTypeDocumentReference() => BasicPackages.cloudFirestore,
      final FieldTypeCustomClass type => type.path,
      _ => null,
    };
  }

  bool get hasDateTime => this is FieldTypeDateTime || (_subtypeNullable != null && _subtypeNullable!.hasDateTime);
  bool get hasTimestamp => this is FieldTypeTimestamp || (_subtypeNullable != null && _subtypeNullable!.hasTimestamp);
  bool get hasDocumentReference =>
      this is FieldTypeDocumentReference || (_subtypeNullable != null && _subtypeNullable!.hasDocumentReference);
  bool get hasCustomClass =>
      this is FieldTypeCustomClass || (_subtypeNullable != null && _subtypeNullable!.hasCustomClass);

  FieldType? get _subtypeNullable {
    return switch (this) {
      final FieldTypeList type => type.subType,
      final FieldTypeMap type => type.subType,
      _ => null,
    };
  }
}
