import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/reference_extensions.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:firestore_builder/src/models/generated_file.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';

List<GeneratedFile> generateUpdatedValue({
  required YamlConfig config,
}) {
  return [
    GeneratedFile(
      library: _updatedValueLibrary(
        config: config,
      ),
      filePath: config.updatedValueClass.path,
    ),
  ];
}

Library _updatedValueLibrary({
  required YamlConfig config,
}) {
  final updatedValueClass = _updatedValueClass(config: config);
  // One class per custom class type, keyed by its suffix so that `TeamSize`
  // and `TeamSize?` share a class (the nullable reference wins, it carries
  // both cases).
  final referenceBySuffix = <String, TypeReference>{};
  for (final field in config.allFields) {
    final suffix = field.updatedValueSuffix;
    final reference = field.customClassReference;
    if (suffix == null || reference == null) {
      continue;
    }
    final existing = referenceBySuffix[suffix];
    if (existing == null || (reference.isNullable ?? false)) {
      referenceBySuffix[suffix] = reference;
    }
  }
  final customClassList = referenceBySuffix.entries.map(
    (entry) => _customUpdatedValueClass(
      suffix: entry.key,
      customClassReference: entry.value,
      config: config,
    ),
  );
  return Library(
    (library) {
      library.body.addAll([
        updatedValueClass,
        ...customClassList,
      ]);
    },
  ).buildLibrary(
    freezedConfig: customClassList.isEmpty
        ? null
        : FreezedConfig(
            withJson: true,
            fileName: config.updatedValueClass.fileName,
            ignoredClassNames: [
              updatedValueClass.name,
            ],
          ),
  );
}

Class _updatedValueClass({
  required YamlConfig config,
}) {
  const reference = BasicTypes.generic;
  const fieldName = UpdatedValueSymbols.valueProperty;
  final field = Field(
    (f) => f
      ..name = fieldName
      ..modifier = FieldModifier.final$
      ..type = reference,
  );
  return Class(
    (c) {
      c
        ..name = UpdatedValueSymbols.updatedValueClass
        ..types.add(reference)
        ..constructors.add(
          Constructor(
            (c) => c
              ..constant = true
              ..requiredParameters.add(
                field.toConstructorParameter,
              ),
          ),
        )
        ..fields.add(field);
    },
  );
}

Class _customUpdatedValueClass({
  required YamlConfig config,
  required String suffix,
  required TypeReference customClassReference,
}) {
  final updatedValueRef = CustomTypes.updatedValue(
    config: config,
    customClass: suffix,
  );
  final parameterName = suffix.camelCase;
  final field = Field(
    (f) => f
      ..name = parameterName
      ..modifier = FieldModifier.final$
      ..type = customClassReference,
  );
  return Class(
    (c) {
      c
        ..name = updatedValueRef.symbol
        ..constructors.add(
          Constructor(
            (c) => c
              ..constant = true
              ..requiredParameters.add(
                field.toConstructorParameter,
              ),
          ),
        )
        ..fields.add(field)
        ..methods.add(
          Method(
            (m) {
              m
                ..returns = BasicTypes.object.nullSafe
                ..type = MethodType.getter
                ..name = UpdatedValueSymbols.valueProperty
                ..lambda = true
                ..body = Code("${FreezedSymbols.toJsonMethod}()['${field.name}']");
            },
          ),
        );
    },
  );
}

extension on Field {
  Parameter get toConstructorParameter => toParameter.inConstructor.inRequiredParameters;
}
