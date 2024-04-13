import 'package:flutter/material.dart';

enum _AppDividerType {
  vertical,
  horizontal,
}

class AppDivider extends StatelessWidget {
  const AppDivider.vertical({
    super.key,
    this.size = 1,
  }) : _type = _AppDividerType.vertical;

  const AppDivider.horizontal({
    super.key,
    this.size = 1,
  }) : _type = _AppDividerType.horizontal;

  final _AppDividerType _type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return switch (_type) {
      _AppDividerType.horizontal => Divider(
          height: size,
          thickness: size,
        ),
      _AppDividerType.vertical => VerticalDivider(
          width: size,
          thickness: size,
        ),
    };
  }
}
