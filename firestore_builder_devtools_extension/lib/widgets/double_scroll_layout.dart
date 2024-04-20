import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoubleScrollLayout extends StatelessWidget {
  const DoubleScrollLayout({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      child: Center(
        child: child,
      ),
    );
  }
}
