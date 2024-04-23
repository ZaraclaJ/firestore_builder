sealed class CollectionNameError {
  const CollectionNameError(this.collectionName);

  final String collectionName;

  String? get error {
    return switch (this) {
      CollectionNameErrorInvalid() => 'Collection name can only contain letters',
      CollectionNameErrorAlreadyExists() => '$collectionName is already used by another collection.',
      CollectionNameErrorEmpty() => null,
    };
  }
}

class CollectionNameErrorEmpty extends CollectionNameError {
  const CollectionNameErrorEmpty(super.name);
}

class CollectionNameErrorInvalid extends CollectionNameError {
  const CollectionNameErrorInvalid(super.name);
}

class CollectionNameErrorAlreadyExists extends CollectionNameError {
  const CollectionNameErrorAlreadyExists(super.name);
}
