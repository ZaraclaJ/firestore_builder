import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/freezed_extensions.dart';
import 'package:firestore_builder/src/extensions.dart/dart_formatter_extensions.dart';
import 'package:firestore_builder/src/helpers/logger.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/collection_field.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

const String _defaultConfigPath = 'pubspec.yaml';

class GeneratorService {
  factory GeneratorService() => _instance;
  const GeneratorService._internal();
  static const GeneratorService _instance = GeneratorService._internal();

  Future<void> generate({
    required String? configFilePath,
  }) async {
    configFilePath ??= _defaultConfigPath;
    final file = File(configFilePath);
    final exist = file.existsSync();
    if (!exist) {
      throw Exception('''
File not found: $configFilePath
You should create a firestore_builder_config.yaml file in the root of your project
You can also indicate the path of your configuration file:
  dart run firestore_builder path/to/your/config.yaml
''');
    }

    if (!file.path.endsWith('.yaml')) {
      throw Exception('Unsupported file extension (not .yaml) : ${file.path}');
    }

    final config = await _parseYamlFile(
      file: file,
    );

    await _generateModels(
      config: config,
    );
  }

  Future<YamlConfig> _parseYamlFile({
    required File file,
  }) async {
    final yamlString = await file.readAsString();

    YamlMap yamlMap;
    try {
      yamlMap = loadYaml(yamlString) as YamlMap;
    } catch (e) {
      throw Exception('''
Error parsing the configuration file: ${file.path}, $e
''');
    }

    return YamlConfig.fromYaml(
      yamlMap,
    );
  }

  Future<void> _generateModels({
    required YamlConfig config,
  }) {
    final modelsPath = config.modelsPath;
    final collections = config.collections;

    final futures = collections.map(
      (c) => _generateFile(
        library: c.modelLibrary,
        filePath: '$modelsPath/${c.fileName}.dart',
      ),
    );

    return Future.wait(futures);
  }

  Future<void> _generateFile({
    required Library library,
    required String filePath,
  }) async {
    final dartLibrary = library.toDart();
    final file = File(filePath);
    await file.create(recursive: true);
    await file.writeAsString(dartLibrary);
    Logger.log('✔︎ $filePath generated');
  }
}

extension CollectionExtensions on Collection {
  String get modelClassName => modelName.pascalCase;

  Library get modelLibrary {
    final modelClass = Class(
      (classBuilder) {
        classBuilder
          ..name = modelClassName
          ..constructors.add(modelConstructor)
          ..fields.addAll(
            fields.map(
              (collectionField) => collectionField.field,
            ),
          );
      },
    );

    return Library(
      (library) {
        library.body.add(modelClass);
      },
    ).toFreezed(withJson: true, fileName: fileName);
  }

  Constructor get modelConstructor {
    return Constructor(
      (constructor) {
        constructor
          ..constant = true
          ..optionalParameters.addAll(
            fields.map(
              (collectionField) => collectionField.parameter,
            ),
          );
      },
    );
  }
}

extension CollectionFieldExtensions on CollectionField {
  Field get field {
    final collectionField = this;
    return Field(
      (fieldBuilder) {
        fieldBuilder
          ..modifier = FieldModifier.final$
          ..type = collectionField.typeReference
          ..name = collectionField.name;
      },
    );
  }

  Parameter get parameter {
    final collectionField = this;
    return Parameter(
      (parameterBuilder) {
        parameterBuilder
          ..type = collectionField.typeReference
          ..covariant
          ..name = collectionField.name
          ..required = true
          ..named = true;
      },
    );
  }
}

/// Generate Firestore Builder
Future<File> _generateFakeFile({
  required String outputPath,
}) async {
  final fakeClass = Class((classBuilder) {
    classBuilder
      ..name = 'FakeClass'
      ..fields.add(
        Field((field) {
          field
            ..name = 'name'
            ..type = refer('String?');
        }),
      );
  });

  final result = Library(
    (library) {
      library.body.add(fakeClass);
    },
  );

  final dartLibrary = result.toDart();
  final file = File('$outputPath/fake_file.dart');
  await file.create(recursive: true);
  await file.writeAsString(dartLibrary);

  Logger.log('✔︎ Fake file generated');
  return file;
}
