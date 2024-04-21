import 'dart:math';

import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/extensions/num_extensions.dart';
import 'package:firestore_builder_devtools_extension/layouts/firebase_config_layout/collection_details.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/theme/constants.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CollectionsBloc extends StatelessWidget {
  const CollectionsBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return _ConstraintsBuilder(
      builder: (columnCount, columnWidth) {
        return _CollectionListView(
          columnCount: columnCount,
          columnWidth: columnWidth,
        );
      },
    );
  }
}

class _CollectionListView extends ConsumerStatefulWidget {
  const _CollectionListView({
    required this.columnCount,
    required this.columnWidth,
  });

  final int columnCount;
  final double columnWidth;

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

  @override
  void didUpdateWidget(covariant _CollectionListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.columnCount != widget.columnCount || oldWidget.columnWidth != widget.columnWidth) {
      scrollToCollection(ref.read(selectedCollectionProvider));
      setState(() {});
    }
  }

  void scrollToCollection(Collection? collection) {
    final columnIndex = collection == null ? 0 : collection.collectionPath.length + 1;
    final indexToScroll = max(columnIndex - widget.columnCount + 1, 0);
    _scrollController.scrollTo(
      index: indexToScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedCollectionProvider, (previous, next) {
      if (previous != next) {
        scrollToCollection(next);
      }
    });

    final selectedCollection = ref.watch(selectedCollectionProvider);
    final pathCollections = ref.watch(selectedCollectionPathProvider);

    final children = [
      const CollectionDetails(
        collection: null,
      ),
      ...pathCollections.map((c) => CollectionDetails(collection: c)),
      if (selectedCollection != null) CollectionDetails(collection: selectedCollection) else const SizedBox(),
    ]
        .map(
          (e) => SizedBox(
            width: widget.columnWidth,
            // height: height,
            child: e,
          ),
        )
        .toList();

    for (var i = children.length; i < widget.columnCount; i++) {
      children.add(SizedBox(width: widget.columnWidth));
    }

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
  }
}

class _ConstraintsBuilder extends StatelessWidget {
  const _ConstraintsBuilder({required this.builder});

  final Widget Function(int columnCount, double columnWidth) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final tableCount = (width ~/ minTableWidth).bounded(minColumnCount, maxColumnCount);
        final childWidth = width / tableCount;
        return builder(tableCount, childWidth);
      },
    );
  }
}
