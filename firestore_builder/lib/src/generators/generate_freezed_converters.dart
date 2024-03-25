import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_annotations.dart';
import 'package:firestore_builder/src/easy_gen/basic_symbols.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/easy_gen/expression_extensions.dart';
import 'package:firestore_builder/src/generators/generate_library.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

Future<void> generateFreezedConverters({
  required YamlConfig config,
}) async {
  final collections = config.allCollections;
  final hasDateTimeField = collections.any((c) => c.fields.any((f) => f.isDateTime));

  if (!hasDateTimeField) {
    return;
  }

  const timestampVarName = 'timestamp';
  const dateTimeVarName = 'dateTime';

  final library = Library(
    (library) {
      library.body.addAll([
        Class(
          (c) {
            c
              ..name = FreezedSymbols.dateTimeConverter
              ..implements.add(
                FreezedTypes.jsonConverterOf(
                  BasicTypes.dateTime,
                  BasicTypes.timestamp,
                ),
              )
              ..constructors.add(
                Constructor(
                  (ctor) {
                    ctor.constant = true;
                  },
                ),
              )
              ..methods.addAll([
                Method(
                  (m) {
                    m
                      ..annotations.add(BasicAnnotations.override)
                      ..returns = BasicTypes.dateTime
                      ..name = FreezedSymbols.fromJsonMethod
                      ..requiredParameters.add(
                        Parameter(
                          (p) => p
                            ..name = timestampVarName
                            ..type = BasicTypes.timestamp,
                        ),
                      )
                      ..lambda = false
                      ..body = const Reference(timestampVarName).method('toDate').returned.statement;
                  },
                ),
                Method(
                  (m) {
                    m
                      ..annotations.add(BasicAnnotations.override)
                      ..returns = BasicTypes.timestamp
                      ..name = FreezedSymbols.toJsonMethod
                      ..requiredParameters.add(
                        Parameter(
                          (p) => p
                            ..name = dateTimeVarName
                            ..type = BasicTypes.dateTime,
                        ),
                      )
                      ..lambda = false
                      ..body = BasicTypes.timestamp
                          .method(
                            'fromDate',
                            positionalArguments: [const Reference(dateTimeVarName)],
                          )
                          .returned
                          .statement;
                  },
                ),
              ]);
          },
        ),
      ]);
    },
  );

  await generateLibrary(
    library: library,
    filePath: config.convertersPath,
  );
}
