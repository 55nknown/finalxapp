// ignore_for_file: unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:point_in_polygon/point_in_polygon.dart';

class PanelDrawerWidget extends StatelessWidget {
  const PanelDrawerWidget({Key? key, required this.onSelect, required this.selectedIndex}) : super(key: key);

  static const panelSize = 80.0;
  static const panels = [
    // line 1
    Offset(0, 1),
    Offset(1, 1),
    Offset(2, 1),
    Offset(3, 1),

    // line 2
    Offset(3, 0),
    Offset(4, 0),
    Offset(5, 0),
    Offset(6, 0),
    Offset(7, 0),
    Offset(8, 0),
  ];

  final int selectedIndex;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        int? index;
        final touchOffset = details.localPosition;

        for (int i = 0; i < panels.length; i++) {
          final offset = panels[i];

          var renderOffset = Offset(offset.dx * panelSize, offset.dy * panelSize);

          List<Offset> vertices = [];

          if ((offset.dy == 1 && offset.dx % 2 == 0) || (offset.dy == 0 && offset.dx % 2 == 1)) {
            renderOffset = Offset(renderOffset.dx - (panelSize / 2) * offset.dx, renderOffset.dy);
            vertices.add(Offset(0 + renderOffset.dx, panelSize + renderOffset.dy));
            vertices.add(Offset((panelSize / 2) + renderOffset.dx, (panelSize - sqrt(pow(panelSize, 2) - pow(panelSize / 2, 2))) + renderOffset.dy));
            vertices.add(Offset(panelSize + renderOffset.dx, panelSize + renderOffset.dy));
          } else {
            renderOffset = Offset(renderOffset.dx - (panelSize / 2) * offset.dx, renderOffset.dy);
            vertices.add(Offset(0 + renderOffset.dx, renderOffset.dy));
            vertices.add(Offset((panelSize / 2) + renderOffset.dx, (sqrt(pow(panelSize, 2) - pow(panelSize / 2, 2))) + renderOffset.dy));
            vertices.add(Offset(panelSize + renderOffset.dx, renderOffset.dy));
          }

          if (Poly.isPointInPolygon(Point(x: touchOffset.dx, y: touchOffset.dy), vertices.map((e) => Point(x: e.dx, y: e.dy)).toList())) {
            index = i;
          }
        }

        if (index != null) onSelect(index);
      },
      child: CustomPaint(
        size: const Size(panelSize * 6 - panelSize, panelSize * 2),
        painter: DrawTriangle(panelSize: panelSize, selectedIndex: selectedIndex, panels: panels),
      ),
    );
  }
}

class DrawTriangle extends CustomPainter {
  final double strokeWidth;
  final double panelSize;
  final int selectedIndex;
  final List<Offset> panels;

  DrawTriangle({
    this.strokeWidth = 5.0,
    this.panelSize = 50.0,
    this.panels = const [],
    required this.selectedIndex,
  });

  void paintPanel(int index, Canvas canvas, Offset offset, {bool fill = false}) {
    var path = Path();
    final painter = Paint()
      ..color = fill ? Colors.grey.withOpacity(.5) : Colors.orange
      ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.bevel;
    var renderOffset = Offset(offset.dx * panelSize, offset.dy * panelSize);

    if ((offset.dy == 1 && offset.dx % 2 == 0) || (offset.dy == 0 && offset.dx % 2 == 1)) {
      renderOffset = Offset(renderOffset.dx - (panelSize / 2) * offset.dx, renderOffset.dy);
      path.moveTo(0 + renderOffset.dx, panelSize + renderOffset.dy);
      path.lineTo((panelSize / 2) + renderOffset.dx, (panelSize - sqrt(pow(panelSize, 2) - pow(panelSize / 2, 2))) + renderOffset.dy);
      path.lineTo(panelSize + renderOffset.dx, panelSize + renderOffset.dy);
    } else {
      renderOffset = Offset(renderOffset.dx - (panelSize / 2) * offset.dx, renderOffset.dy + strokeWidth);
      path.moveTo(0 + renderOffset.dx, renderOffset.dy);
      path.lineTo((panelSize / 2) + renderOffset.dx, (sqrt(pow(panelSize, 2) - pow(panelSize / 2, 2))) + renderOffset.dy);
      path.lineTo(panelSize + renderOffset.dx, renderOffset.dy);
    }

    path.close();
    canvas.drawPath(path, painter);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int index = 0; index < panels.length; index++) {
      if (index == selectedIndex) {
        paintPanel(index, canvas, panels[index], fill: true);
      }
      paintPanel(index, canvas, panels[index]);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
