# Firestore Builder

[![Pub](https://img.shields.io/pub/v/firestore_builder.svg)](https://pub.dartlang.org/packages/firestore_builder)

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/social_card.png" width="600" />

# Installation

## Setup Firestore for your project

Follow the official [Firebase documentation](https://firebase.google.com/docs/flutter/setup?platform=ios) to add Firestore to your project.

This will make you add the following dependencies :

```bash
flutter pub add firebase_core
flutter pub add cloud_firestore
```

## Dependencies

Add the `firestore_builder` package in `dev_dependencies`. You can do this by running this command:

```bash
flutter pub add dev:firestore_builder
```

## Configuration

Generation is based on a YAML configuration file (`firestore_builder_config.yaml`) that describes the structure of the database you want.

### A. Use the devtools extension

The simplest way to configure the generation is to use the devtools extension app :

- Launch your app in debug mode
- Open the devtool

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/open_devtools.png" width="600" />

- Select the firestore_builder tab and enable the extension

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/enable_firestore_builder.png" width="600" />

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/devtools_tabs.jpg" width="600" />

- Use the extension app to build the configuration file
- You can save the configuration file directly from the extensions app, this will create the `firestore_builder_config.yaml` at the root of your project

<img src="https://raw.githubusercontent.com/ZaraclaJ/firestore_builder/main/img/save_config.png" width="600" />

### B. Or manually create the configuration file

If you master the configuration syntax, you can manually create the `firestore_builder_config.yaml` file at the root of your project. Here is a simple configuration file with only one collection (users)

```yaml
firestore_builder:
  output: lib/firestore
  use_riverpod: true
  collections:
    - collection:
        collection_name: users
        model_name: user
        fields:
          - name: String
          - age: int
```

## Add external dependencies

The generated code is based on external packages. Thanks [@remi_rousselet](https://twitter.com/remi_rousselet) for this.

- The [Freezed](https://pub.dev/packages/freezed) package to make models classes immutable and equatable.

- (optionally) The [Riverpod](https://pub.dev/packages/riverpod) package. My personal favorite state management package

You need to add these dependencies :

### Freezed

```bash
flutter pub add freezed_annotation
flutter pub add dev:build_runner
flutter pub add dev:freezed
flutter pub add json_annotation
flutter pub add dev:json_serializable
```

### Riverpod (Optional)

```bash
flutter pub add flutter_riverpod
```

### Generate the Freezed classes

Do not forget to run the build_runner command line each time you generate new code :

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Generation result

With a simple configuration file, here is the result of the generation:

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
