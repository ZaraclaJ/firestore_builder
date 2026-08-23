#!/bin/sh
# Compiles the generated code against a real Flutter project. Run before
# publishing.
set -e

cd "$(dirname "$0")/../example"

flutter pub get
dart run firestore_builder
dart run build_runner build --delete-conflicting-outputs
flutter analyze --fatal-infos
