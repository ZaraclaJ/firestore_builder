import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/reference_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';

Future<void> generateUpdatedValue({
  required YamlConfig config,
}) async {
  await generateLibrary(
    library: _updatedValueLibrary(
      config: config,
    ),
    filePath: config.updatedValueClass.path,
  );
}

Library _updatedValueLibrary({
  required YamlConfig config,
}) {
  final updatedValueClass = _updatedValueClass(config: config);
  final customClassList = config.allFields
      .map(
        (element) => element.customClassReference,
      )
      .whereNotNull()
      .toSet()
      .map(
        (ref) => _customUpdatedValueClass(
          customClassReference: ref,
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
  required TypeReference customClassReference,
}) {
  final customClassName = customClassReference.symbolName;
  final updatedValueRef = CustomTypes.updatedValue(
    config: config,
    customClass: customClassName,
  );
  final parameterName = customClassName.camelCase;
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
