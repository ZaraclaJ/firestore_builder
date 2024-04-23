import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/buttons/tile_button.dart';
import 'package:firestore_builder_devtools_extension/dialogs/collection_dialog.dart';
import 'package:firestore_builder_devtools_extension/dialogs/field_dialog.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/collection_options_buttton.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/field_list.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/sub_collection_list.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
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
        const _StartCollectionButton(),
        const AppDivider.horizontal(),
        const Expanded(
          child: SubCollectionList(),
        ),
        if (isCollection) ...[
          const AppDivider.horizontal(),
          const _AddFieldButton(),
          const AppDivider.horizontal(),
          const Expanded(
            flex: 2,
            child: FieldList(),
          ),
        ],
      ],
    );
  }
}

class _StartCollectionButton extends ConsumerWidget {
  const _StartCollectionButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TileButton.add(
      text: 'Start collection',
      onTap: () async {
        final collection = ref.read(collectionGetter);
        await CollectionDialog.showStart(
          context: context,
          inCollection: collection,
        );
      },
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (collection != null) ...[
                  const AppGap.regular(),
                  CollectionOptionsButton(
                    collection: collection,
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

class _AddFieldButton extends ConsumerWidget {
  const _AddFieldButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TileButton.add(
      text: 'Add field',
      onTap: () async {
        final collection = ref.read(collectionGetter);
        await FieldDialog.showCreate(
          context: context,
          collection: collection,
        );
      },
    );
  }
}
