import 'package:firestore_builder_devtools_extension/dialogs/collection_dialog.dart';
import 'package:firestore_builder_devtools_extension/states/config_view_model.dart';
import 'package:firestore_builder_devtools_extension/states/getters.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_card.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_divider.dart';
import 'package:firestore_builder_devtools_extension/widgets/app_list_tile.dart';
import 'package:firestore_builder_devtools_extension/widgets/confirmation_dialog.dart';
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
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _controller.toggle();
            },
            child: CompositedTransformFollower(
              link: _link,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: _Overlay(controller: _controller),
              ),
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

class _Overlay extends ConsumerWidget {
  const _Overlay({
    required this.controller,
  });

  final OverlayPortalController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IntrinsicWidth(
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Action(
              icon: Icons.edit,
              title: 'Edit Collection',
              onTap: () {
                final collection = ref.read(collectionGetter);
                if (collection == null) {
                  return;
                }
                controller.hide();

                CollectionDialog.showEdit(
                  context: context,
                  collection: collection,
                );
              },
            ),
            const AppDivider.horizontal(),
            _Action(
              icon: FontAwesomeIcons.trash,
              title: 'Delete Collection',
              onTap: () async {
                final collection = ref.read(collectionGetter);
                if (collection == null) {
                  return;
                }
                controller.hide();

                final viewModel = ref.read(configViewModelProvider);
                final confirm = await ConfirmationDialog.show(
                  context: context,
                  title: 'Delete Collection',
                  description: 'Are you sure you want to delete this collection?',
                  validateLabel: 'Delete',
                  isDestructive: true,
                );

                if (confirm != null && confirm) {
                  viewModel.removeCollection(collection);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: Icon(
        icon,
        size: 16,
      ),
      title: title,
      onTap: onTap,
    );
  }
}
