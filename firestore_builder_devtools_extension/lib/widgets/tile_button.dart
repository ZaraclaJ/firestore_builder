import 'package:firestore_builder_devtools_extension/theme/widgets/app_padding.dart';
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  const TileButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
    this.color,
    super.key,
  });

  final IconData icon;
  final void Function() onTap;
  final String? tooltip;
  final Color? color;

  static const double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox.square(
          dimension: iconSize,
          child: AppPadding.small(
            child: FittedBox(
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
