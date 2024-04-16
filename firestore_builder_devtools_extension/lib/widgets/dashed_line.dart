import 'package:firestore_builder_devtools_extension/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashedLinePainter extends CustomPainter {
  const DashedLinePainter({
    required this.color,
    required this.dots,
  });

  final Color color;
  final int dots;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final lineWidth = width / dots;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (var i = 0; i < dots; i++) {
      final x = i * lineWidth;
      canvas.drawLine(Offset(x, 0), Offset(x + lineWidth / 2, 0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedLine extends StatelessWidget {
  const DashedLine({
    required this.dots,
    super.key,
  });

  final int dots;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return CustomPaint(
      painter: DashedLinePainter(
        color: theme.dividerColor,
        dots: dots,
      ),
    );
  }
}
