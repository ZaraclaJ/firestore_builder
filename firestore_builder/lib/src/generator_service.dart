import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/code_builder_extensions.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/extensions.dart/dart_formatter_extensions.dart';
import 'package:firestore_builder/src/helpers/constants.dart';
import 'package:firestore_builder/src/helpers/logger.dart';
import 'package:firestore_builder/src/models/collection.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

class GeneratorService {
  factory GeneratorService() => _instance;
  const GeneratorService._internal();
  static const GeneratorService _instance = GeneratorService._internal();

  Future<void> generate({
    required String? configFilePath,
  }) async {
    configFilePath ??= defaultConfigPath;
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
    return Library(
      (library) {
        library.body.addAll([
          _modelClass,
          _idClass,
        ]);
      },
    ).buildLibrary(
      toFreezed: true,
      withJson: true,
      fileName: fileName,
    );
  }

  Class get _modelClass {
    return Class(
      (classBuilder) {
        classBuilder
          ..name = modelClassName
          ..constructors.add(
            _fromFirestoreFactory,
          )
          ..fields.addAll([
            ...fields.map(
              (collectionField) => collectionField.staticKeyField(),
            ),
            ...fields.map(
              (collectionField) => collectionField.field(
                className: modelClassName,
              ),
            ),
            _idField,
          ])
          ..methods.addAll([
            _idGetter,
            _toFirestoreMethod,
          ]);
      },
    );
  }

  Field get _idField {
    return Field(
      (field) {
        field
          ..name = databaseIdName
          ..type = BasicTypes.string
          ..assignment = literalString('').code
          ..modifier = FieldModifier.final$
          ..annotations.add(
            BasicAnnotations.jsonKey(
              includeFromJson: false,
              includeToJson: false,
            ),
          );
      },
    );
  }

  Method get _idGetter {
    final idClassRef = Reference(_idClass.name);
    return Method(
      (method) {
        method
          ..name = '${modelClassName.camelCase}Id'
          ..type = MethodType.getter
          ..returns = idClassRef
          ..lambda = true
          ..body = idClassRef.call([
            Reference(_idField.name),
          ]).code;
      },
    );
  }

  Constructor get _fromFirestoreFactory {
    const snapshotVarName = 'snapshot';
    const dataVarName = 'data';
    return Constructor(
      (ctor) {
        ctor
          ..factory = true
          ..name = fromFirestoreFactoryName
          ..requiredParameters.addAll([
            Parameter(
              (p) {
                p
                  ..name = snapshotVarName
                  ..type = FirestoreTypes.documentSnapshotOf(
                    BasicTypes.json,
                  );
              },
            ),
            Parameter(
              (p) {
                p
                  ..name = 'options'
                  ..type = FirestoreTypes.snapshotOptions(
                    isNullable: true,
                  );
              },
            ),
          ])
          ..body = Block.of([
            declareFinal(dataVarName)
                .assign(
                  const Reference(snapshotVarName).method('data'),
                )
                .statement,
            Reference(modelClassName)
                .method(
                  FreezedMethods.fromJson,
                  [const Reference(dataVarName).nullChecked],
                )
                .method(FreezedMethods.copyWith, [], {
                  _idField.name: const Reference(snapshotVarName).property('id'),
                })
                .returned
                .statement,
          ]);
      },
    );
  }

  Method get _toFirestoreMethod {
    const jsonVarName = 'json';

    return Method(
      (method) {
        method
          ..name = toFirestoreMethodName
          ..returns = BasicTypes.json
          ..body = Block.of([
            declareFinal(jsonVarName)
                .assign(
                  const Reference('toJson').call([]),
                )
                .statement,
            const Reference(jsonVarName).returned.statement,
          ]);
      },
    );
  }

  Class get _idClass {
    return Class(
      (classBuilder) {
        const fieldName = 'value';
        const fieldType = BasicTypes.string;

        classBuilder
          ..name = '${modelClassName}Id'
          ..fields.add(
            Field(
              (field) {
                field
                  ..name = fieldName
                  ..type = fieldType
                  ..modifier = FieldModifier.final$;
              },
            ),
          );
      },
    ).buildClassConstructor(optional: false);
  }
}
