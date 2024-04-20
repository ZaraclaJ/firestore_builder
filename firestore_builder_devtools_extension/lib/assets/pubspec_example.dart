const yamlConfigExample = '''
firestore_builder:
  project_name: example
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
