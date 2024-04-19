import 'package:firestore_builder/firestore_builder.dart';
import 'package:firestore_builder_devtools_extension/extensions/widget_extensions.dart';
import 'package:firestore_builder_devtools_extension/states/config_states.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:firestore_builder_devtools_extension/theme/widgets/app_gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PathDetails extends ConsumerWidget {
  const PathDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final backgroundColor = colors.secondaryContainer;
    final foregroundColor = colors.onSecondaryContainer;

    final selectedCollection = ref.watch(selectedCollectionProvider);
    final selectedCollectionPath = ref.watch(selectedCollectionPathProvider);
    final children = [
      _HomeButton(
        color: foregroundColor,
      ),
      ...selectedCollectionPath.map(
        (collection) => _PathItem(
          collection: collection,
          color: foregroundColor,
        ),
      ),
      if (selectedCollection != null) _PathItem(collection: selectedCollection, color: foregroundColor),
    ]
        .joinWidgets(
          Icon(Icons.chevron_right, color: foregroundColor),
        )
        .joinWidgets(const AppGap.small());

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: context.borderRadius.regular.copyWith(
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      height: 48,
      child: ListView.builder(
        padding: context.edgeInsets.regular,
        scrollDirection: Axis.horizontal,
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
      ),
    );
  }
}

class _PathItem extends ConsumerWidget {
  const _PathItem({
    required this.collection,
    required this.color,
  });

  final Collection collection;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: InkWell(
        child: Text(
          collection.name,
          style: context.typos.labelMedium?.copyWith(color: context.colors.onPrimaryContainer),
        ),
        onTap: () {
          ref.read(configViewModelProvider).selectCollection(collection);
        },
      ),
    );
  }
}

class _HomeButton extends ConsumerWidget {
  const _HomeButton({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Icon(Icons.home, color: color),
      onTap: () {
        ref.read(configViewModelProvider).selectCollection(null);
      },
    );
  }
}
