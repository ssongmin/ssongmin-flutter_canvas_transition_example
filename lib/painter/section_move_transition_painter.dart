import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class SectionMoveTransitionPainter extends CustomProgressPainter {
  @override
  String get title => 'SectionMoveTransition';

  final double textHeight = 70;

  SectionMoveTransitionPainter({required super.progress, required super.text});

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.saveLayer(Rect.largest, Paint());
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.clipRect(fullRect);

    final progress = this.progress * 3;

    final textList = text.split("\n");

    final textSize = size.height / textList.length;

    Paint textEraserPaint = Paint();
    textEraserPaint.color = Colors.black;
    for (int i = 0; i < size.height; i += (textHeight.toInt())) {
      Rect testRect =
          Rect.fromLTRB(0, i.toDouble(), size.width - size.width * progress + i, (i + textHeight).toDouble());

      canvas.drawRect(testRect, textEraserPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
