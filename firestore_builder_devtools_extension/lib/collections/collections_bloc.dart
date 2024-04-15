import 'package:firestore_builder_devtools_extension/collections/collection_details.dart';
import 'package:firestore_builder_devtools_extension/path/path_details.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CollectionsBloc extends StatelessWidget {
  const CollectionsBloc({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final cardColor = colors.surface;

    return AppPadding.regular(
      child: Card(
        color: cardColor,
        surfaceTintColor: cardColor,
        shape: BeveledRectangleBorder(
          borderRadius: context.borderRadius.regular,
        ),
        child: const Column(
          children: [
            PathDetails(),
            AppDivider.horizontal(),
            Expanded(
              child: _CollectionListView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionListView extends ConsumerStatefulWidget {
  const _CollectionListView();

  @override
  ConsumerState<_CollectionListView> createState() => _PageViewState();
}

class _PageViewState extends ConsumerState<_CollectionListView> {
  late ItemScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ItemScrollController();
  }

  void _scrollToEnd(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedCollectionProvider, (previous, next) {
      if (previous != next) {
        final index = next == null ? 0 : next.collectionPath.length;
        _scrollToEnd(index);
      }
    });

    final selectedCollection = ref.watch(selectedCollectionProvider);
    final pathCollections = ref.watch(selectedCollectionPathProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final childWidth = width / 2;
        final children = [
          const CollectionDetails(
            collection: null,
          ),
          ...pathCollections.map((c) => CollectionDetails(collection: c)),
          if (selectedCollection != null) CollectionDetails(collection: selectedCollection) else const SizedBox(),
        ]
            .map(
              (e) => SizedBox(
                width: childWidth,
                height: height,
                child: e,
              ),
            )
            .toList();

        return ScrollablePositionedList.separated(
          itemScrollController: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: children.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const AppDivider.vertical();
          },
          itemBuilder: (BuildContext context, int index) {
            return children[index];
          },
        );
      },
    );
  }
}
