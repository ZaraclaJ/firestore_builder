import 'package:code_builder/code_builder.dart';
import 'package:firestore_builder/src/easy_gen/basic_packages.dart';

abstract class BasicAnnotations {
  /// @freezed
  static Expression get freezed {
    return const Reference(
      'freezed',
      BasicPackages.freezedAnnotation,
    );
  }

  /// @Default(value)
  static Expression defaultFreezed(Expression value) {
    return const Reference('Default', BasicPackages.freezedAnnotation).call([value]);
  }
}
