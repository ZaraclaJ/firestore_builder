import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';

sealed class FieldType {
  const FieldType({
    required this.isNullable,
    required this.configLight,
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
    required YamlConfig config,
  }) {
    final isNullable = symbol.isNullable;
    final pureType = symbol.withoutQuestionMark;

    return switch (pureType) {
      final a when a.extractListType() != null => FieldTypeList(
          subType: FieldType.fromDartSymbol(
            symbol: a.extractListType()!,
            path: path,
            config: config,
          ),
          isNullable: isNullable,
          configLight: config,
        ),
      final a when a.extractMapType() != null => FieldTypeMap(
          subType: FieldType.fromDartSymbol(
            symbol: a.extractMapType()!,
            path: path,
            config: config,
          ),
          isNullable: isNullable,
          configLight: config,
        ),
      BasicSymbols.string => FieldTypeString(
          isNullable: isNullable,
          configLight: config,
        ),
      BasicSymbols.int => FieldTypeInt(
          isNullable: isNullable,
          configLight: config,
        ),
      BasicSymbols.double => FieldTypeDouble(
          isNullable: isNullable,
          configLight: config,
        ),
      BasicSymbols.bool => FieldTypeBool(
          isNullable: isNullable,
          configLight: config,
        ),
      BasicSymbols.dateTime => FieldTypeDateTime(
          isNullable: isNullable,
          configLight: config,
        ),
      BasicSymbols.timestamp => FieldTypeTimestamp(
          isNullable: isNullable,
          configLight: config,
        ),
      FirestoreSymbols.documentReferenceClass => FieldTypeDocumentReference(
          isNullable: isNullable,
          configLight: config,
        ),
      _ when path != null => FieldTypeCustomClass(
          className: pureType,
          isNullable: isNullable,
          path: path,
          configLight: config,
        ),
      _ => throw Exception('Type $symbol is not recognized'),
    };
  }

  /// The configuration of the project
  final YamlConfig configLight;

  /// Indicates if the field is nullable
  final bool isNullable;
}

class FieldTypeString extends FieldType {
  const FieldTypeString({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeInt extends FieldType {
  const FieldTypeInt({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeDouble extends FieldType {
  const FieldTypeDouble({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeBool extends FieldType {
  const FieldTypeBool({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeTimestamp extends FieldType {
  const FieldTypeTimestamp({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeDateTime extends FieldType {
  const FieldTypeDateTime({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeDocumentReference extends FieldType {
  const FieldTypeDocumentReference({
    required super.isNullable,
    required super.configLight,
  });
}

class FieldTypeCustomClass extends FieldType {
  const FieldTypeCustomClass({
    required this.className,
    required this.path,
    required super.isNullable,
    required super.configLight,
  });

  final String className;
  final String path;
}

class FieldTypeList extends FieldType {
  const FieldTypeList({
    required this.subType,
    required super.isNullable,
    required super.configLight,
  });

  final FieldType subType;
}

class FieldTypeMap extends FieldType {
  const FieldTypeMap({
    required this.subType,
    required super.isNullable,
    required super.configLight,
  });

  final FieldType subType;
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
      final FieldTypeCustomClass type => type.path.toPackageUrl(
          projectName: configLight.projectName,
        ),
      _ => null,
    };
  }

  String? get customClassName {
    return switch (this) {
      final FieldTypeCustomClass type => type.className,
      _ => null,
    };
  }

  String? get customClassPath {
    return switch (this) {
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
