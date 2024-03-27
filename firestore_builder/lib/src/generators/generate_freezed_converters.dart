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
  final hasTimestampField = collections.any((c) => c.fields.any((f) => f.isTimestamp));
  final hasDocumentReferenceField = collections.any((c) => c.fields.any((f) => f.isDocumentReference));

  if ([
    hasDateTimeField,
    hasTimestampField,
    hasDocumentReferenceField,
  ].every((e) => !e)) {
    return;
  }

  final library = Library(
    (library) {
      library.body.addAll([
        if (hasDateTimeField) _dateTimeConverter,
        if (hasTimestampField) _timestampConverter,
        if (hasDocumentReferenceField) _documentReferenceConverter,
      ]);
    },
  );

  await generateLibrary(
    library: library,
    filePath: config.convertersPath,
  );
}

Class get _dateTimeConverter {
  const timestampVarName = 'timestamp';
  const dateTimeVarName = 'dateTime';
  return Class(
    (c) {
      c
        ..name = FreezedSymbols.dateTimeConverter
        ..implements.add(
          CustomTypes.jsonConverterOf(
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
  );
}

Class get _timestampConverter {
  const timestampVarName = 'timestamp';
  return Class(
    (c) {
      c
        ..name = FreezedSymbols.timestampConverter
        ..implements.add(
          CustomTypes.jsonConverterOf(
            BasicTypes.timestamp,
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
                ..returns = BasicTypes.timestamp
                ..name = FreezedSymbols.fromJsonMethod
                ..requiredParameters.add(
                  Parameter(
                    (p) => p
                      ..name = timestampVarName
                      ..type = BasicTypes.timestamp,
                  ),
                )
                ..lambda = false
                ..body = const Reference(timestampVarName).returned.statement;
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
                      ..name = timestampVarName
                      ..type = BasicTypes.timestamp,
                  ),
                )
                ..lambda = false
                ..body = const Reference(timestampVarName).returned.statement;
            },
          ),
        ]);
    },
  );
}

Class get _documentReferenceConverter {
  const documentReferenceVarName = 'documentReference';
  return Class(
    (c) {
      c
        ..name = FreezedSymbols.documentReferenceConverter
        ..implements.add(
          CustomTypes.jsonConverterOf(
            FirestoreTypes.documentReference,
            FirestoreTypes.documentReference,
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
                ..returns = FirestoreTypes.documentReference
                ..name = FreezedSymbols.fromJsonMethod
                ..requiredParameters.add(
                  Parameter(
                    (p) => p
                      ..name = documentReferenceVarName
                      ..type = FirestoreTypes.documentReference,
                  ),
                )
                ..lambda = false
                ..body = const Reference(documentReferenceVarName).returned.statement;
            },
          ),
          Method(
            (m) {
              m
                ..annotations.add(BasicAnnotations.override)
                ..returns = FirestoreTypes.documentReference
                ..name = FreezedSymbols.toJsonMethod
                ..requiredParameters.add(
                  Parameter(
                    (p) => p
                      ..name = documentReferenceVarName
                      ..type = FirestoreTypes.documentReference,
                  ),
                )
                ..lambda = false
                ..body = const Reference(documentReferenceVarName).returned.statement;
            },
          ),
        ]);
    },
  );
}
