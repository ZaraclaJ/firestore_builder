import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';

sealed class FieldType {
  const FieldType({
    required this.isNullable,
  });

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
      final a when a.extractListType() != null => FieldTypeList(
          subType: FieldType.fromDartSymbol(
            symbol: a.extractListType()!,
            path: path,
          ),
          isNullable: isNullable,
          path: path,
        ),
      final a when a.extractMapType() != null => FieldTypeMap(
          subType: FieldType.fromDartSymbol(
            symbol: a.extractMapType()!,
            path: path,
          ),
          isNullable: isNullable,
          path: path,
        ),
      BasicSymbols.string => FieldTypeString(isNullable: isNullable),
      BasicSymbols.int => FieldTypeInt(isNullable: isNullable),
      BasicSymbols.double => FieldTypeDouble(isNullable: isNullable),
      BasicSymbols.bool => FieldTypeBool(isNullable: isNullable),
      BasicSymbols.dateTime => FieldTypeDateTime(isNullable: isNullable),
      BasicSymbols.timestamp => FieldTypeTimestamp(isNullable: isNullable),
      FirestoreSymbols.documentReferenceClass => FieldTypeDocumentReference(isNullable: isNullable),
      _ when path != null => FieldTypeCustomClass(
          className: pureType,
          isNullable: isNullable,
          path: path,
        ),
      _ => throw Exception('Type $symbol is not recognized'),
    };
  }

  final bool isNullable;
}

class FieldTypeString extends FieldType {
  const FieldTypeString({
    required super.isNullable,
  });
}

class FieldTypeInt extends FieldType {
  const FieldTypeInt({
    required super.isNullable,
  });
}

class FieldTypeDouble extends FieldType {
  const FieldTypeDouble({
    required super.isNullable,
  });
}

class FieldTypeBool extends FieldType {
  const FieldTypeBool({
    required super.isNullable,
  });
}

class FieldTypeTimestamp extends FieldType {
  const FieldTypeTimestamp({
    required super.isNullable,
  });
}

class FieldTypeDateTime extends FieldType {
  const FieldTypeDateTime({
    required super.isNullable,
  });
}

class FieldTypeDocumentReference extends FieldType {
  const FieldTypeDocumentReference({
    required super.isNullable,
  });
}

class FieldTypeCustomClass extends FieldType {
  const FieldTypeCustomClass({
    required this.className,
    required this.path,
    required super.isNullable,
  });

  final String className;
  final String path;
}

class FieldTypeList extends FieldType {
  const FieldTypeList({
    required this.subType,
    required this.path,
    required super.isNullable,
  });

  final FieldType subType;
  final String? path;
}

class FieldTypeMap extends FieldType {
  const FieldTypeMap({
    required this.subType,
    required this.path,
    required super.isNullable,
  });

  final FieldType subType;
  final String? path;
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
    final fieldType = this;
    return switch (fieldType) {
      FieldTypeString() => BasicSymbols.string,
      FieldTypeInt() => BasicSymbols.int,
      FieldTypeDouble() => BasicSymbols.double,
      FieldTypeBool() => BasicSymbols.bool,
      FieldTypeTimestamp() => BasicSymbols.timestamp,
      FieldTypeDateTime() => BasicSymbols.dateTime,
      FieldTypeDocumentReference() => FirestoreSymbols.documentReferenceClass,
      FieldTypeList() => BasicSymbols.list,
      FieldTypeMap() => BasicSymbols.map,
      final FieldTypeCustomClass fieldType => fieldType.className,
    };
  }

  String? get packageUrl {
    return switch (this) {
      FieldTypeTimestamp() => BasicPackages.cloudFirestore,
      FieldTypeDocumentReference() => BasicPackages.cloudFirestore,
      final FieldTypeCustomClass type => type.path,
      _ => null,
    };
  }

  bool get hasDateTime => this is FieldTypeDateTime || (subTypeNullable != null && subTypeNullable!.hasDateTime);
  bool get hasTimestamp => this is FieldTypeTimestamp || (subTypeNullable != null && subTypeNullable!.hasTimestamp);
  bool get hasDocumentReference =>
      this is FieldTypeDocumentReference || (subTypeNullable != null && subTypeNullable!.hasDocumentReference);
  bool get hasCustomClass =>
      this is FieldTypeCustomClass || (subTypeNullable != null && subTypeNullable!.hasCustomClass);

  FieldType? get subTypeNullable {
    return switch (this) {
      final FieldTypeList type => type.subType,
      final FieldTypeMap type => type.subType,
      _ => null,
    };
  }
}
