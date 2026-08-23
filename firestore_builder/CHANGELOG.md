## 0.1.6

- Documentation rewritten: why and how to use the package, full configuration reference, walkthrough of every generated file, workflow and limitations.
- Example app trimmed to a single documented page that compiles the generated code; `tool/check_example.sh` runs it before publishing.
- Fix `set<Model>`: the document is now written at the id given in parameter instead of the model's own id.
- Fix the usage message of the command line.

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
