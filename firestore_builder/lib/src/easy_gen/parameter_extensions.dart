import 'package:code_builder/code_builder.dart';

extension ParameterExtensions on Parameter {
  Parameter get inConstructor {
    return rebuild(
      (parameterBuilder) => parameterBuilder
        ..toThis = true
        ..type = null,
    );
  }
}
