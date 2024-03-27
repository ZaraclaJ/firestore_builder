import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';
import 'package:firestore_builder/src/easy_gen/basic_types.dart';
import 'package:firestore_builder/src/models/yaml_config.dart';

abstract class BasicAnnotations {
  /// @override
  static Expression override = const Reference(
    'override',
  );

  /// @JsonKey
  static Expression jsonKey({
    Expression? name,
    bool? includeFromJson,
    bool? includeToJson,
  }) =>
      const Reference(
        'JsonKey',
        BasicPackages.freezedAnnotation,
      ).call([], {
        if (name != null) 'name': name,
        if (includeFromJson != null) 'includeFromJson': literalBool(includeFromJson),
        if (includeToJson != null) 'includeToJson': literalBool(includeToJson),
      });

  /// @Freezed
  static Expression freezed({
    required bool? toJson,
    required bool? fromJson,
  }) {
    return const Reference(
      'Freezed',
      BasicPackages.freezedAnnotation,
    ).call([], {
      if (toJson != null) 'toJson': literalBool(toJson),
      if (fromJson != null) 'fromJson': literalBool(fromJson),
    });
  }

  /// @Default(value)
  static Expression defaultFreezed(Expression value) {
    return const Reference('Default', BasicPackages.freezedAnnotation).call([value]);
  }

  /// @DateTimeConverter()
  static Expression dateTimeConverter({
    required YamlConfig config,
  }) {
    return CustomTypes.dateTimeConverter(config: config).call([]);
  }

  /// @TimestampConverter()
  static Expression timestampConverter({
    required YamlConfig config,
  }) {
    return CustomTypes.timestampConverter(config: config).call([]);
  }

  /// @DocumentReferenceConverter()
  static Expression documentReferenceConverter({
    required YamlConfig config,
  }) {
    return CustomTypes.documentReferenceConverter(config: config).call([]);
  }
}
