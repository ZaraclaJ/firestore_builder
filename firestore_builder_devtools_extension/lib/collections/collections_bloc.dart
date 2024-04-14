import 'package:firestore_builder_devtools_extension/collections/collection_details.dart';
import 'package:firestore_builder_devtools_extension/path/path_details.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionsBloc extends ConsumerWidget {
  const CollectionsBloc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCollection = ref.watch(selectedCollectionProvider);
    final previousCollection = ref.watch(selectedCollectionPathProvider).lastOrNull;
    return AppPadding.regular(
      child: Card(
        shape: BeveledRectangleBorder(
          borderRadius: context.borderRadius.regular,
        ),
        child: Column(
          children: [
            const PathDetails(),
            const AppDivider.horizontal(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CollectionDetails(
                      collection: previousCollection,
                    ),
                  ),
                  const AppDivider.vertical(),
                  Expanded(
                    child: selectedCollection != null
                        ? CollectionDetails(
                            collection: selectedCollection,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
