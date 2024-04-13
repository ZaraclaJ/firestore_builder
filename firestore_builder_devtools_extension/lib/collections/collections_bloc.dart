import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/collections/start_collection_button.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionsBloc extends StatelessWidget {
  const CollectionsBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPadding.regular(
      child: Card(
        child: Row(
          children: [
            Expanded(
              child: _CollectionList(),
            ),
            AppDivider.vertical(),
            Expanded(
              child: SizedBox(),
            ),
            AppDivider.vertical(),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionList extends ConsumerWidget {
  const _CollectionList();
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

class _CollectionItem extends StatelessWidget {
  const _CollectionItem({required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(collection.name),
      trailing: const Icon(Icons.chevron_right),
      leading: const SizedBox(),
    );
  }
}
