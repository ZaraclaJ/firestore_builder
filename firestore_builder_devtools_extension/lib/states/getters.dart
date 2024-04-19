import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _collectionPathGetter = Provider<List<String>>(
  (ref) => throw Exception('_collectionPathGetter not found'),
);

final collectionGetter = Provider<Collection?>(
  (ref) {
    final config = ref.watch(configProvider);
    final path = ref.watch(_collectionPathGetter);

    return config.collectionFromPath(path);
  },
  dependencies: [_collectionPathGetter],
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
