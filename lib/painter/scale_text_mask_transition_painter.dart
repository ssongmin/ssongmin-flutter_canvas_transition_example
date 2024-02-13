import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class ScaleTextMaskTransitionPainter extends CustomProgressPainter {
  @override
  String get title => 'ScaleTextMaskTransition';

  ScaleTextMaskTransitionPainter({required super.progress, required super.text});

  final double textSize = 24;

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(fullRect);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1 * (1 + progress * 50));
    canvas.translate(-size.width / 2, -size.height / 2);

    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.black;
    backgroundPaint.blendMode = BlendMode.srcOut;

    ///Text Painter
    // TextSpan textSpan = TextSpan(text: text, style: AppTextStyle.bold24);
    TextSpan textSpan =
        TextSpan(text: text, style: TextStyle(fontSize: textSize, color: Colors.white, fontWeight: FontWeight.bold));
    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    final textWidth = textPainter.size.width;
    final textHeight = textPainter.size.height;

    ///센터에 먼저 하나 그려줌
    textPainter.paint(canvas, Offset(size.width / 2 - textWidth / 2, size.height / 2 - textHeight / 2));

    for (int i = 0; i < size.height / textHeight / 2; i++) {
      final yOffset = textHeight * i;

      if (i % 2 == 0) {
        textPainter.paint(canvas, Offset(size.width / 2 - textWidth / 2, size.height / 2 - textHeight / 2 + yOffset));

        textPainter.paint(canvas, Offset(size.width / 2 - textWidth / 2, size.height / 2 - textHeight / 2 - yOffset));
      }

      for (int j = 1; j < size.width / textWidth / 2; j++) {
        final xOffset = textWidth * j;

        if (i % 2 == 1 && j % 2 == 1) {
          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 + xOffset, size.height / 2 - textHeight / 2 + yOffset));

          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 - xOffset, size.height / 2 - textHeight / 2 + yOffset));

          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 + xOffset, size.height / 2 - textHeight / 2 - yOffset));

          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 - xOffset, size.height / 2 - textHeight / 2 - yOffset));
        }
        if (i % 2 == 0 && j % 2 == 0) {
          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 + xOffset, size.height / 2 - textHeight / 2 + yOffset));

          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 - xOffset, size.height / 2 - textHeight / 2 + yOffset));

          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 + xOffset, size.height / 2 - textHeight / 2 - yOffset));

          textPainter.paint(
              canvas, Offset(size.width / 2 - textWidth / 2 - xOffset, size.height / 2 - textHeight / 2 - yOffset));
        }
      }
    }

    canvas.drawRect(fullRect, backgroundPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
