import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/collection_options_buttton.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_list_tile.dart';
import 'package:firestore_builder_devtools_extension/widgets/on_hover_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCollectionList extends ConsumerWidget {
  const SubCollectionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionGetter);
    final subCollections = ref.watch(subCollectionsProvider(collection));
    return Material(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subCollections.length,
        itemBuilder: (BuildContext context, int index) {
          final collection = subCollections[index];
          return _CollectionItem(
            collection: collection,
          );
        },
      ),
    );
  }
}

class _CollectionItem extends ConsumerWidget {
  const _CollectionItem({required this.collection});

  final Collection collection;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(isCollectionSelectedProvider(collection));

    return OnHoverBuilder(
      builder: (hover) {
        return AppListTile(
          onTap: () {
            ref.read(configViewModelProvider).selectCollection(collection);
          },
          titleWidget: Row(
            children: [
              AppListTileTitleText(collection.name),
              if (hover) ...[
                const AppGap.regular(),
                AppListTileTitleText(
                  '(${collection.modelName})',
                  color: context.colors.onBackground,
                ),
              ],
            ],
          ),
          trailing: const Icon(Icons.chevron_right),
          selected: isSelected,
          leading: CollectionOptionsButton(
            collection: collection,
            size: 24,
            foregroundColor: context.colors.primary,
            isDisplayed: hover,
          ),
        );
      },
    );
  }
}
