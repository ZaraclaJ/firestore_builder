const pubspecExample = '''
name: example
description: "A new Flutter project."

publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  cloud_firestore: ^4.15.7
  cupertino_icons: ^1.0.6
  firebase_core: ^2.27.0
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.10
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.8
  custom_lint: ^0.6.2
  firestore_builder:
    path: ..
  flutter_lints: ^3.0.0
  flutter_test:
    sdk: flutter
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  very_good_analysis: ^5.1.0

flutter:
  uses-material-design: true

firestore_builder:
  output: lib/firestore
  clear: false
  collections:
    - collection:
        collection_name: teams
        model_name: team
        fields:
          - name: String
          - description: String?
          - user_count: int
          - created_at: 
              type: DateTime
              accept_field_value: true
          - dates: List<Timestamp?>?
          - bytes: List<List<int>>?
          - labels: 
              type: List<String>
              accept_field_value: true
          - presences: Map<bool>?    
          - team_ref: DocumentReference?
          - team_size: 
              type: TeamSize
              path: models/enums/team_size.dart      
      sub_collections:
        - collection:
            collection_name: users
            model_name: user
            fields:
              - name: String
              - current_job: String?
              - age: int
          sub_collections:
            - collection:
                collection_name: items
                model_name: item
                fields:
                  - name: String
        - collection:
            collection_name: messages
            model_name: message
            fields:
              - content: String
              - date: Timestamp?
    - collection:
        collection_name: tasks
        model_name: task
        fields:
          - name: String
          - description: String?
          - done: bool
''';
