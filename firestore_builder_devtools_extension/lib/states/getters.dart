import 'package:firestore_builder/firestore_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectionGetter = Provider<Collection?>(
  (ref) => throw Exception('Collection not found'),
);

class CollectionGetterInitializer extends StatelessWidget {
  const CollectionGetterInitializer({
    required this.child,
    required this.collection,
    super.key,
  });

  final Widget child;
  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        collectionGetter.overrideWithValue(collection),
      ],
      child: child,
    );
  }
}
