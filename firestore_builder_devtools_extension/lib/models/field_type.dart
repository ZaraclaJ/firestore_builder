import 'package:firestore_builder/firestore_builder.dart';

enum FieldTypeEnum {
  string,
  int,
  double,
  bool,
  timestamp,
  dateTime,
  documentReference,
  list,
  map,
  customClass;
}

const FieldTypeNullable defaultFieldTypeNullable = (
  fieldType: FieldTypeEnum.string,
  nullable: false,
);

extension FieldTypeEnumExtensions on FieldTypeEnum? {
  bool get hasSubType => this == FieldTypeEnum.list || this == FieldTypeEnum.map;
}

typedef FieldTypeNullable = ({
  FieldTypeEnum fieldType,
  bool nullable,
});

extension FieldTypeExtensions on FieldType {
  Map<int, FieldTypeNullable> getFieldTypeEnumMap(int level) {
    final fieldType = this;
    final isNullable = fieldType.isNullable;
    final subType = fieldType.subTypeNullable;
    return {
      level: switch (fieldType) {
        FieldTypeString() => (fieldType: FieldTypeEnum.string, nullable: isNullable),
        FieldTypeInt() => (fieldType: FieldTypeEnum.int, nullable: isNullable),
        FieldTypeDouble() => (fieldType: FieldTypeEnum.double, nullable: isNullable),
        FieldTypeBool() => (fieldType: FieldTypeEnum.bool, nullable: isNullable),
        FieldTypeTimestamp() => (fieldType: FieldTypeEnum.timestamp, nullable: isNullable),
        FieldTypeDateTime() => (fieldType: FieldTypeEnum.dateTime, nullable: isNullable),
        FieldTypeDocumentReference() => (fieldType: FieldTypeEnum.documentReference, nullable: isNullable),
        FieldTypeList() => (fieldType: FieldTypeEnum.list, nullable: isNullable),
        FieldTypeMap() => (fieldType: FieldTypeEnum.map, nullable: isNullable),
        FieldTypeCustomClass() => (fieldType: FieldTypeEnum.customClass, nullable: isNullable),
      },
      if (subType != null) ...subType.getFieldTypeEnumMap(level + 1),
    };
  }
}

extension FieldTypeEnumMapExtensions on Map<int, FieldTypeNullable> {
  FieldType getFieldType({
    required int level,
    required String customClassName,
    required String customClassPath,
    required YamlConfig config,
  }) {
    final typeNullable = this[level] ?? defaultFieldTypeNullable;
    final type = typeNullable.fieldType;
    final nullable = typeNullable.nullable;

    return switch (type) {
      FieldTypeEnum.string => FieldTypeString(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.int => FieldTypeInt(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.double => FieldTypeDouble(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.bool => FieldTypeBool(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.timestamp => FieldTypeTimestamp(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.dateTime => FieldTypeDateTime(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.documentReference => FieldTypeDocumentReference(
          isNullable: nullable,
          configLight: config,
        ),
      FieldTypeEnum.list => FieldTypeList(
          isNullable: nullable,
          subType: getFieldType(
            level: level + 1,
            customClassName: customClassName,
            customClassPath: customClassPath,
            config: config,
          ),
          configLight: config,
        ),
      FieldTypeEnum.map => FieldTypeMap(
          isNullable: nullable,
          subType: getFieldType(
            level: level + 1,
            customClassName: customClassName,
            customClassPath: customClassPath,
            config: config,
          ),
          configLight: config,
        ),
      FieldTypeEnum.customClass => FieldTypeCustomClass(
          isNullable: nullable,
          className: customClassName,
          path: customClassPath,
          configLight: config,
        ),
    };
  }
}
