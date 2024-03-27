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
  static FieldType fromDartSymbol({
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
      _ => FieldTypeCustomClass(
          className: pureType,
          isNullable: isNullable,
          path: path,
        ),
    };
  }

  final bool isNullable;

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
    return switch (this) {
      FieldTypeList() => BasicSymbols.list,
      FieldTypeString() => BasicSymbols.string,
      FieldTypeInt() => BasicSymbols.int,
      FieldTypeDouble() => BasicSymbols.double,
      FieldTypeBool() => BasicSymbols.bool,
      FieldTypeTimestamp() => BasicSymbols.timestamp,
      FieldTypeDocumentReference() => FirestoreSymbols.documentReferenceClass,
      FieldTypeDateTime() => BasicSymbols.dateTime,
      FieldTypeMap() => BasicSymbols.map,
      final FieldTypeCustomClass field => field.className,
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
  final String? path;
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
