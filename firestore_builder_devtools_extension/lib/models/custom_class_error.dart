sealed class CustomClassNameError {
  const CustomClassNameError(this.className);

  final String className;

  String? get error {
    return switch (this) {
      CustomClassNameErrorInvalid() => 'Custom class name can only contain letters.',
      CustomClassNameErrorAlreadyExists() => '$className is already used by another collection.',
      CustomClassNameErrorEmpty() => null,
    };
  }
}

class CustomClassNameErrorEmpty extends CustomClassNameError {
  const CustomClassNameErrorEmpty(super.className);
}

class CustomClassNameErrorInvalid extends CustomClassNameError {
  const CustomClassNameErrorInvalid(super.className);
}

class CustomClassNameErrorAlreadyExists extends CustomClassNameError {
  const CustomClassNameErrorAlreadyExists(super.className);
}

sealed class CustomClassPathError {
  const CustomClassPathError(this.filePath);

  final String filePath;

  String? get error {
    return switch (this) {
      CustomClassPathErrorEmpty() => null,
    };
  }
}

class CustomClassPathErrorEmpty extends CustomClassPathError {
  const CustomClassPathErrorEmpty(super.filePath);
}
