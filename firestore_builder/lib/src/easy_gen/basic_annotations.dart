import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';

abstract class BasicAnnotations {
  /// @JsonKey
  static Expression jsonKey({Expression? name}) => const Reference(
        'JsonKey',
        BasicPackages.freezedAnnotation,
      ).call([], {
        if (name != null) 'name': name,
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
}
