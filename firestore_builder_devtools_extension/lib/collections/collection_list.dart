import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/collections/start_collection_button.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionList extends ConsumerWidget {
  const CollectionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collections = ref.watch(collectionsProvider);
    return ListView.builder(
      itemCount: collections.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const StartCollectionButton();
        }
        final collection = collections[index - 1];
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
