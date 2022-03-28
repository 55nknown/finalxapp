import 'dart:math';

import 'package:flutter/material.dart';

class PanelDrawerWidget extends StatelessWidget {
  const PanelDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        print(details.localPosition);
      },
      child: CustomPaint(
        size: const Size(75 * 6, 75 * 2),
        painter: DrawTriangle(),
      ),
    );
  }
}

class DrawTriangle extends CustomPainter {
  late Paint painter;

  DrawTriangle() {
    painter = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeJoin = StrokeJoin.bevel;
  }

  void paintPanel(Path path, Offset offset) {
    const panelSize = 75.0;

    path.moveTo(0, panelSize);
    path.lineTo(panelSize / 2, panelSize - sqrt(pow(panelSize, 2) - pow(panelSize / 2, 2)));
    path.lineTo(panelSize, panelSize);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    final panels = [
      // line 1
      const Offset(1, 0),
      const Offset(1, 1),
      const Offset(1, 2),
      const Offset(1, 3),

      // line 2
      const Offset(0, 3),
      const Offset(0, 4),
      const Offset(0, 5),
      const Offset(0, 6),
      const Offset(0, 7),
      const Offset(0, 8),
    ];

    for (var offset in panels) {
      paintPanel(path, offset);
    }

    path.close();
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
