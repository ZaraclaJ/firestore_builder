import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/add_field_button.dart';
import 'package:firestore_builder_devtools_extension/buttons/start_collection_button.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/collection_options_buttton.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _isCollectionProvider = Provider<bool>(
  (ref) {
    return ref.watch(collectionGetter) != null;
  },
  dependencies: [collectionGetter],
);

class CollectionDetails extends StatelessWidget {
  const CollectionDetails({
    required this.collection,
    super.key,
  });

  final Collection? collection;

  @override
  Widget build(BuildContext context) {
    return CollectionGetterInitializer(
      collection: collection,
      child: const _Layout(),
    );
  }
}

class _Layout extends ConsumerWidget {
  const _Layout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCollection = ref.watch(_isCollectionProvider);
    return Column(
      children: [
        const _CollectionInfo(),
        const StartCollectionButton(),
        const AppDivider.horizontal(),
        const Expanded(
          child: _SubCollectionList(),
        ),
        if (isCollection) ...[
          const AppDivider.horizontal(),
          const AddFieldButton(),
          const AppDivider.horizontal(),
          const Expanded(
            flex: 2,
            child: _FieldList(),
          ),
        ],
      ],
    );
  }
}

class _CollectionInfo extends ConsumerWidget {
  const _CollectionInfo();

  double get _iconSize => 24;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collection = ref.watch(collectionGetter);
    final text = collection == null ? 'Root' : '${collection.name} (${collection.modelName})';
    final icon = collection == null ? FontAwesomeIcons.database : Icons.article;

    final colors = context.colors;
    final backgroundColor = colors.secondaryContainer;
    final foregroundColor = colors.onSecondaryContainer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
          color: backgroundColor,
          child: AppPadding.regular(
            child: Row(
              children: [
                Icon(
                  icon,
                  size: _iconSize,
                  color: foregroundColor,
                ),
                const AppGap.regular(),
                Expanded(
                  child: Text(
                    text,
                    style: context.typos.labelLarge?.copyWith(
                      color: foregroundColor,
                    ),
                  ),
                ),
                if (collection != null) ...[
                  const AppGap.regular(),
                  CollectionOptionsButton(
                    foregroundColor: foregroundColor,
                    size: _iconSize,
                  ),
                ],
              ],
            ),
          ),
        ),
        const AppDivider.horizontal(),
      ],
    );
  }
}

class _SubCollectionList extends ConsumerWidget {
  const _SubCollectionList();

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
    return AppListTile(
      onTap: () {
        ref.read(configViewModelProvider).selectCollection(collection);
      },
      title: collection.name,
      trailing: const Icon(Icons.chevron_right),
      selected: isSelected,
    );
  }
}

class _FieldList extends ConsumerWidget {
  const _FieldList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = ref.watch(collectionGetter)?.fields ?? [];
    return Material(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: fields.length,
        itemBuilder: (BuildContext context, int index) {
          final field = fields[index];
          return _FieldItem(
            field: field,
          );
        },
      ),
    );
  }
}

class _FieldItem extends StatelessWidget {
  const _FieldItem({required this.field});

  final CollectionField field;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: '${field.name}: ${field.type.typeReference.symbolName}',
      titleWidget: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${field.name}:'),
          const AppGap.small(),
          Expanded(
            child: Text(
              field.type.typeReference.symbolName,
              style: context.typos.labelLarge?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
