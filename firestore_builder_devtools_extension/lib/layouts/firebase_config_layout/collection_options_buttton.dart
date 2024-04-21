import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_card.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollectionOptionsButton extends ConsumerStatefulWidget {
  const CollectionOptionsButton({
    required this.size,
    required this.foregroundColor,
    super.key,
  });

  final double size;
  final Color foregroundColor;

  @override
  ConsumerState<CollectionOptionsButton> createState() => _CollectionOptionsButtonState();
}

class _CollectionOptionsButtonState extends ConsumerState<CollectionOptionsButton> {
  late final OverlayPortalController _controller;
  late final LayerLink _link;

  @override
  void initState() {
    super.initState();
    _link = LayerLink();
    _controller = OverlayPortalController();
  }

  @override
  Widget build(BuildContext context) {
    final collection = ref.watch(collectionGetter);
    if (collection == null) {
      return const SizedBox();
    }

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomLeft,
            child: const Align(
              alignment: AlignmentDirectional.topStart,
              child: _Overlay(),
            ),
          );
        },
        child: InkWell(
          onTap: () {
            _controller.toggle();
          },
          child: Icon(
            Icons.more_vert,
            size: widget.size,
            color: widget.foregroundColor,
          ),
        ),
      ),
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppListTile(
              leading: const Icon(
                FontAwesomeIcons.trash,
                size: 16,
              ),
              title: 'Delete Collection',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}