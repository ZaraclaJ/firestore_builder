import 'dart:io';

import 'package:firestore_builder/src/generators/generators.dart';
import 'package:test/test.dart';

const String _configFilePath = 'test/firestore_builder_config.yaml';

void main() {
  test(
    'generate',
    () async {
      await generate(
        configFilePath: _configFilePath,
      );

      final team = File('test/output/models/team.dart').readAsStringSync();
      expect(
        'unknownEnumValue: TeamSize.small'.allMatches(team).length,
        2,
        reason: 'unknown_enum_value must be emitted as JsonKey.unknownEnumValue '
            'on the enum field and on the list of enums field',
      );

      final updatedValue = File(
        'test/output/models/updated_value.dart',
      ).readAsStringSync();
      expect(updatedValue, contains('class UpdatedValueTeamSize '));
      expect(updatedValue, contains('class UpdatedValueTeamSizeList '));

      final queryService = File(
        'test/output/services/firestore_query_service.dart',
      ).readAsStringSync();
      expect(queryService, contains('UpdatedValueTeamSizeList? teamSizes'));
    },
  );
}
