sealed class ModelNameError {
  const ModelNameError(this.modelName);

  final String modelName;

  String? get error {
    return switch (this) {
      ModelNameErrorInvalid() => 'Model name can only contain letters.',
      ModelNameErrorAlreadyExists() => '$modelName is already used by another collection.',
      ModelNameErrorEmpty() => null,
    };
  }
}

class ModelNameErrorEmpty extends ModelNameError {
  const ModelNameErrorEmpty(super.modelName);
}

class ModelNameErrorInvalid extends ModelNameError {
  const ModelNameErrorInvalid(super.modelName);
}

class ModelNameErrorAlreadyExists extends ModelNameError {
  const ModelNameErrorAlreadyExists(super.modelName);
}
