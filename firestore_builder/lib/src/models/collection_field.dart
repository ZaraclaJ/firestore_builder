import 'package:code_builder/code_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/models/field_type.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class CollectionField extends Equatable {
  const CollectionField({
    required this.name,
    required this.type,
    required this.acceptFieldValue,
    required this.configLight,
  });

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

    if (first is String) {
      type = first;
      acceptFieldValue = false;
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
    } else {
      throw Exception(
        '''
Invalid field definition, invalid field: $yamlMap''',
      );
    }

    final fieldType = FieldType.fromDartSymbol(type);

    return CollectionField(
      name: name,
      type: fieldType,
      acceptFieldValue: acceptFieldValue ?? false,
      configLight: configLight,
    );
  }

  final String name;
  final FieldType type;
  final bool acceptFieldValue;
  final YamlConfig configLight;

  TypeReference get _typeReference {
    return type.typeReference;
  }

  bool get isDateTime => type is FieldTypeDateTime;

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
            if (isDateTime) BasicAnnotations.dateTimeConverter(config: configLight),
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

  @override
  List<Object> get props => [
        name,
        type,
        acceptFieldValue,
        configLight,
      ];
}
