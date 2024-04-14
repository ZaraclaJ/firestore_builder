import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/collections/start_collection_button.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _collectionGetter = Provider<Collection?>(
  (ref) => throw Exception('Collection not found'),
);

class CollectionDetails extends StatelessWidget {
  const CollectionDetails({
    required this.collection,
    super.key,
  });

  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        _collectionGetter.overrideWithValue(collection),
      ],
      child: const _Layout(),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        Expanded(child: _SubCollectionList()),
      ],
    );
  }
}

class _SubCollectionList extends ConsumerWidget {
  const _SubCollectionList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(_collectionGetter);
    final subCollections = ref.watch(subCollectionsProvider(collection));
    return ListView.builder(
      itemCount: subCollections.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const StartCollectionButton();
        }
        final collection = subCollections[index - 1];
        return _CollectionItem(
          collection: collection,
        );
      },
    );
  }
}

class _CollectionItem extends ConsumerWidget {
  const _CollectionItem({required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final isSelected = ref.watch(isCollectionSelectedProvider(collection));
    return ListTile(
      onTap: () {
        ref.read(selectedCollectionProvider.notifier).state = collection;
      },
      title: Text(collection.name),
      trailing: const Icon(Icons.chevron_right),
      leading: const SizedBox(),
      selected: isSelected,
      selectedTileColor: colors.primaryContainer,
    );
  }
}
