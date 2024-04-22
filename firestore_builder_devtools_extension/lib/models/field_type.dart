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
  FieldType getFieldType(int level) {
    final typeNullable = this[level] ?? defaultFieldTypeNullable;
    final type = typeNullable.fieldType;
    final nullable = typeNullable.nullable;

    return switch (type) {
      FieldTypeEnum.string => FieldTypeString(
          isNullable: nullable,
        ),
      FieldTypeEnum.int => FieldTypeInt(
          isNullable: nullable,
        ),
      FieldTypeEnum.double => FieldTypeDouble(
          isNullable: nullable,
        ),
      FieldTypeEnum.bool => FieldTypeBool(
          isNullable: nullable,
        ),
      FieldTypeEnum.timestamp => FieldTypeTimestamp(
          isNullable: nullable,
        ),
      FieldTypeEnum.dateTime => FieldTypeDateTime(
          isNullable: nullable,
        ),
      FieldTypeEnum.documentReference => FieldTypeDocumentReference(
          isNullable: nullable,
        ),
      FieldTypeEnum.list => FieldTypeList(
          isNullable: nullable,
          subType: getFieldType(level + 1),
          path: null,
        ),
      FieldTypeEnum.map => FieldTypeMap(
          isNullable: nullable,
          subType: getFieldType(level + 1),
          path: null,
        ),
      FieldTypeEnum.customClass => FieldTypeCustomClass(
          isNullable: nullable,
          className: 'TODO',
          path: 'TODO',
        ),
    };
  }
}
