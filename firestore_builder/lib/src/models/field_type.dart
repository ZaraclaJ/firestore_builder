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
  /// - `List<T>`
  /// - `Map<T>`
  static FieldType fromDartSymbol(String symbol) {
    final isNullable = symbol.isNullable;
    final pureType = symbol.withoutQuestionMark;

    return switch (pureType) {
      final a when a.extractListType() != null => FieldTypeList(
          subType: FieldType.fromDartSymbol(
            a.extractListType()!,
          ),
          isNullable: isNullable,
        ),
      final a when a.extractMapType() != null => FieldTypeMap(
          subType: FieldType.fromDartSymbol(
            a.extractMapType()!,
          ),
          isNullable: isNullable,
        ),
      BasicSymbols.string => FieldTypeString(isNullable: isNullable),
      BasicSymbols.int => FieldTypeInt(isNullable: isNullable),
      BasicSymbols.double => FieldTypeDouble(isNullable: isNullable),
      BasicSymbols.bool => FieldTypeBool(isNullable: isNullable),
      BasicSymbols.timestamp => FieldTypeTimestamp(isNullable: isNullable),
      BasicSymbols.dateTime => FieldTypeDateTime(isNullable: isNullable),
      _ => throw Exception('Unknown field type: $symbol'),
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
      FieldTypeDateTime() => BasicSymbols.dateTime,
      FieldTypeMap() => BasicSymbols.map,
    };
  }

  String? get packageUrl {
    return switch (this) {
      FieldTypeTimestamp() => BasicPackages.cloudFirestore,
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

class FieldTypeList extends FieldType {
  const FieldTypeList({
    required this.subType,
    required super.isNullable,
  });

  final FieldType subType;
}

class FieldTypeMap extends FieldType {
  const FieldTypeMap({
    required this.subType,
    required super.isNullable,
  });

  final FieldType subType;
}
