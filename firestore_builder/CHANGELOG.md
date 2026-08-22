## 0.1.5

- Add the `unknown_enum_value` field option: emits `JsonKey(unknownEnumValue: ...)` so unknown enum values decode to a fallback instead of throwing.
- Fix the generation of `UpdatedValue` classes for `List` and `Map` of custom classes (`List<MyEnum>` produced an invalid class name), and share one class between a custom class field and its nullable variant.
- Devtools extension: input for `unknown_enum_value` on custom class fields, lint dependencies updated.

## 0.1.1 -> 0.1.4

Update readme

## 0.1.0

Create the devtools extension to easily generate the configuration file

## 0.0.1

First version of firestore_builder.
See the documentation to learn how to use it
