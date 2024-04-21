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
