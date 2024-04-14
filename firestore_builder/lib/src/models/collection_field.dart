import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/field_type.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

part 'collection_field.freezed.dart';

@freezed
class CollectionField with _$CollectionField {
  const factory CollectionField({
    required String name,
    required FieldType type,
    required bool acceptFieldValue,
    required YamlConfig configLight,
  }) = _CollectionField;

  const CollectionField._();
  factory CollectionField.fromYaml({
    required YamlMap yamlMap,
    required YamlConfig configLight,
  }) {
    final keys = yamlMap.keys.whereType<String>();
    final values = yamlMap.values;
    if (keys.length != 1 || values.length != 1) {
      throw Exception(
        '''
Invalid field definition, there should be only one key and one value: $yamlMap''',
      );
    }
    final name = keys.first;
    final first = values.first;

    final String type;
    final bool? acceptFieldValue;
    final String? path;

    if (first is String) {
      type = first;
      acceptFieldValue = false;
      path = null;
    } else if (first is YamlMap) {
      final yamlType = first[typeKey];
      if (yamlType is! String) {
        throw Exception(
          '''
Invalid field definition, missing or invalid $typeKey key: $first''',
        );
      }

      type = yamlType;

      final yamlAcceptFieldValue = first[acceptFieldValueKey];
      if (yamlAcceptFieldValue is! bool?) {
        throw Exception(
          '''
Invalid field definition, invalid $acceptFieldValueKey key: $first''',
        );
      }

      acceptFieldValue = yamlAcceptFieldValue;

      final yamlPath = first[pathKey];
      if (yamlPath is! String?) {
        throw Exception(
          '''
Invalid field definition, invalid $pathKey key: $first''',
        );
      }

      path = yamlPath;
    } else {
      throw Exception(
        '''
Invalid field definition, invalid field: $yamlMap''',
      );
    }

    final fieldType = FieldType.fromDartSymbol(
      symbol: type,
      path: path?.toPackageUrl(projectName: configLight.projectName),
    );

    return CollectionField(
      name: name,
      type: fieldType,
      acceptFieldValue: acceptFieldValue ?? false,
      configLight: configLight,
    );
  }

  TypeReference get _typeReference {
    return type.typeReference;
  }

  bool get hasDateTime => type.hasDateTime;
  bool get hasTimestamp => type.hasTimestamp;
  bool get hasDocumentReference => type.hasDocumentReference;

  TypeReference? get customClassReference {
    if (type.hasCustomClass) {
      return _typeReference;
    }
    return null;
  }

  String get fieldName => name.camelCase;

  String get keyVarName => '${fieldName}FieldKey';
  String get firestoreFieldValueName => '${fieldName}FieldValue';

  Field staticKeyField() {
    return Field(
      (fieldBuilder) {
        fieldBuilder
          ..static = true
          ..modifier = FieldModifier.constant
          ..type = BasicTypes.string
          ..name = keyVarName
          ..assignment = literalString(name).code;
      },
    );
  }

  Field field({
    required String className,
  }) {
    return Field(
      (fieldBuilder) {
        fieldBuilder
          ..modifier = FieldModifier.final$
          ..type = _typeReference
          ..name = fieldName
          ..annotations.addAll([
            if (hasDateTime) BasicAnnotations.dateTimeConverter(config: configLight),
            if (hasTimestamp) BasicAnnotations.timestampConverter(config: configLight),
            if (hasDocumentReference) BasicAnnotations.documentReferenceConverter(config: configLight),
            BasicAnnotations.jsonKey(
              name: Reference(className).property(keyVarName),
            ),
          ]);
      },
    );
  }

  Field? firestoreFieldValue() {
    if (!acceptFieldValue) {
      return null;
    }

    return Field(
      (fieldBuilder) {
        fieldBuilder
          ..modifier = FieldModifier.final$
          ..type = FirestoreTypes.fieldValue(isNullable: true)
          ..name = firestoreFieldValueName
          ..annotations.add(
            BasicAnnotations.jsonKey(
              includeFromJson: false,
              includeToJson: false,
            ),
          );
      },
    );
  }

  Parameter parameter() {
    final collectionField = this;
    return Parameter(
      (parameterBuilder) {
        parameterBuilder
          ..type = collectionField._typeReference
          ..covariant
          ..name = collectionField.fieldName
          ..required = true
          ..named = true;
      },
    );
  }
}
