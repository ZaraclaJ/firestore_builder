import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/extensions.dart/string_extensions.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class CollectionField extends Equatable {
  const CollectionField({
    required this.name,
    required this.type,
    required this.isNullable,
  });

  factory CollectionField.fromYaml(
    YamlMap yamlMap,
  ) {
    final keys = yamlMap.keys.whereType<String>();
    final values = yamlMap.values.whereType<String>();
    if (keys.length != 1 || values.length != 1) {
      throw Exception(
        '''
Invalid field definition, there should be only one key and one value: $yamlMap''',
      );
    }

    final name = keys.first;
    final type = values.first;

    final isNullable = type.isNullable;
    final typeName = type.withoutQuestionMark;

    final fieldType = FieldType.fromDartSymbol(typeName);
    if (fieldType == null) {
      throw Exception('Unknown field type: $type');
    }

    return CollectionField(
      name: name,
      type: fieldType,
      isNullable: isNullable,
    );
  }

  final String name;
  final FieldType type;
  final bool isNullable;

  TypeReference get _typeReference {
    return TypeReference(
      (b) => b
        ..symbol = type.dartSymbol
        ..url = type.packageUrl
        ..isNullable = isNullable,
    );
  }

  String get fieldName => name.camelCase;

  String get _keyVarName => '${fieldName}FieldKey';

  Field staticKeyField() {
    return Field(
      (fieldBuilder) {
        fieldBuilder
          ..static = true
          ..modifier = FieldModifier.constant
          ..type = BasicTypes.string
          ..name = _keyVarName
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
          ..annotations.add(
            BasicAnnotations.jsonKey(
              name: Reference(className).property(_keyVarName),
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
        isNullable,
      ];
}

enum FieldType {
  string,
  int,
  double,
  bool,
  timestamp,
  dateTime;

  static FieldType? fromDartSymbol(String symbol) {
    return FieldType.values.firstWhereOrNull(
      (element) => element.dartSymbol == symbol,
    );
  }

  String? get packageUrl {
    return switch (this) {
      FieldType.timestamp => BasicPackages.cloudFirestore,
      _ => null,
    };
  }

  String get dartSymbol {
    return switch (this) {
      FieldType.string => BasicSymbols.string,
      FieldType.int => BasicSymbols.int,
      FieldType.double => BasicSymbols.double,
      FieldType.bool => BasicSymbols.bool,
      FieldType.timestamp => BasicSymbols.timestamp,
      FieldType.dateTime => BasicSymbols.dateTime,
    };
  }
}
