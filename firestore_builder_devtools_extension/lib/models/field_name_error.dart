sealed class FieldNameError {
  const FieldNameError(this.fieldName);

  final String fieldName;

  String? get error {
    return switch (this) {
      FieldNameErrorInvalid() => 'Field name can only contain letters.',
      FieldNameErrorAlreadyExists() => '$fieldName is already used in this collection.',
      FieldNameErrorEmpty() => null,
    };
  }
}

class FieldNameErrorEmpty extends FieldNameError {
  const FieldNameErrorEmpty(super.fieldName);
}

class FieldNameErrorInvalid extends FieldNameError {
  const FieldNameErrorInvalid(super.fieldName);
}

class FieldNameErrorAlreadyExists extends FieldNameError {
  const FieldNameErrorAlreadyExists(super.fieldName);
}
