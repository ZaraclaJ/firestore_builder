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
      FieldTypeEnum.string => FieldType.string(
          isNullable: nullable,
        ),
      FieldTypeEnum.int => FieldType.int(
          isNullable: nullable,
        ),
      FieldTypeEnum.double => FieldType.double(
          isNullable: nullable,
        ),
      FieldTypeEnum.bool => FieldType.bool(
          isNullable: nullable,
        ),
      FieldTypeEnum.timestamp => FieldType.timestamp(
          isNullable: nullable,
        ),
      FieldTypeEnum.dateTime => FieldType.dateTime(
          isNullable: nullable,
        ),
      FieldTypeEnum.documentReference => FieldType.documentReference(
          isNullable: nullable,
        ),
      FieldTypeEnum.list => FieldType.list(
          isNullable: nullable,
          subType: getFieldType(level + 1),
          path: null,
        ),
      FieldTypeEnum.map => FieldType.map(
          isNullable: nullable,
          subType: getFieldType(level + 1),
          path: null,
        ),
      FieldTypeEnum.customClass => FieldType.customClass(
          isNullable: nullable,
          className: 'TODO',
          path: null,
        ),
    };
  }
}
