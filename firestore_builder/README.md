# Firestore Builder

![social_card.png](../img/social_card.png)

# Installation

## Dependencies

Add the `firestore_builder` package in `dev_dependencies` .You can do this by running this command:

```bash
flutter pub add dev:firestore_builder
```

## Configuration

Generation is based on a YAML configuration file that describes the structure of the database you want.

Add the `firestore_builder_config.yaml` file at the root of your project. Here is a simple configuration file with only one collection (users)

```yaml
firestore_builder:
  output: lib/firestore
  collections:
    - collection:
        collection_name: users
        model_name: user
        fields:
          - name: String
          - age: int
```

## Setup Firestore for your project

Follow the official [Firebase documentation](https://firebase.google.com/docs/flutter/setup?platform=ios) to add Firestore to your project.

This will make you add the following dependencies :

```bash
flutter pub add firebase_core
flutter pub add cloud_firestore
```

## Add external dependencies

The generated code is based on the [Freezed](https://pub.dev/packages/freezed) and [Riverpod](https://pub.dev/packages/riverpod) packages. (Thanks [@remi_rousselet](https://twitter.com/remi_rousselet) for this). Go check the respective documentation to see how to use them.

### Freezed

Add the required dependencies. Run this command :

```bash
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

### Riverpod (Optional)

Add the required dependencies. Run this command :

```bash
flutter pub add flutter_riverpod
```

# Usage

## Generate the code

Just run the following command to generate all the code you need

```bash
dart run firestore_builder firestore_builder_config.yaml
```

Do not forget to run the build_runner after to generate the freezed classes :

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Generation result

```
lib
-- firestore
	-- models
		-- updated_value.dart
		-- user.dart
		-- user.freezed.dart
		-- user.g.dart
	-- services
		-- firestore_query_service.dart
		-- firestore_reference_service.dart
		-- firestore_stream_service.dart
	-- states
		-- user_states.dart
```

- `updated_value.dart` is a helper class that allows to update some properties of a document
- `user.dart` is the model class of the user collection.
- `firestore_query_service.dart` is the service to make API call (get, add, delete, update, …)
- `firestore_reference_service.dart` is the service to easily access to the Firestore references (documents or collections)
- `firestore_stream_service.dart` is the service to consume Firestore data through streams
- `user_states.dart` is where the Riverpod providers are defined
