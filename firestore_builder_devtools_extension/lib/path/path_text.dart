import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter/widgets.dart';

class PathText extends StatelessWidget {
  const PathText({
    required this.collection,
    super.key,
  });

  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    final collection = this.collection;
    final collectionPath = (collection != null)
        ? [
            ...collection.collectionPath.map((e) => e.name),
            collection.name,
          ].join('/')
        : '';

    return Text('/$collectionPath');
  }
}
