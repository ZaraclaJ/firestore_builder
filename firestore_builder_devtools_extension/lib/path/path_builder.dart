import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter/widgets.dart';

class PathBuilder extends StatelessWidget {
  const PathBuilder({
    required this.collection,
    required this.builder,
    super.key,
  });

  final Collection? collection;

  final Widget Function(String path) builder;

  @override
  Widget build(BuildContext context) {
    final collection = this.collection;
    final collectionPath = (collection != null)
        ? [
            ...collection.collectionPath.map((e) => e.name),
            collection.name,
          ].join('/')
        : '';
    return builder('/$collectionPath');
  }
}
