import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class TextMoveTransitionPainter extends CustomProgressPainter {
  @override
  String get title => 'TextMoveTransition';

  TextMoveTransitionPainter({required super.progress, required super.text});

  final double textSize = 73;

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);

    ///화면 넘치는거 잘라줌
    canvas.clipRect(fullRect);

    ///왼쪽에서 내려오는 Text
    TextSpan textSpan = TextSpan(
        text: text,
        // style: AppTextStyle.bold64.copyWith(color: Colors.orange, backgroundColor: Colors.black, fontSize: 70));
        style: TextStyle(
            fontSize: textSize, color: Colors.orange, fontWeight: FontWeight.bold, backgroundColor: Colors.black));
    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    double leftTextOffsetX = textPainter.height - 9;
    // double leftTextOffsetY = -(size.width / 2) + textPainter.height / 2;
    double leftTextOffsetY = 80 + 1000 * progress;

    final xCenter = size.width / 2 - textPainter.width / 2;
    final yCenter = size.height / 2 - textPainter.height / 2;
    // canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(
        textPainter.width / 2 + leftTextOffsetX + xCenter, textPainter.height / 2 + leftTextOffsetY + yCenter);
    // canvas.rotate(45 / 360);
    canvas.rotate(-pi / 2);
    // canvas.translate(-size.width / 2, -size.height / 2);
    canvas.translate(
        -(textPainter.width / 2 + leftTextOffsetX + xCenter), -(textPainter.height / 2 + leftTextOffsetY + yCenter));

    textPainter.paint(canvas, Offset(leftTextOffsetX, leftTextOffsetY));

    canvas.restore();

    ///오른쪽에서 올라가는 Text
    canvas.saveLayer(Rect.largest, Paint());

    canvas.clipRect(fullRect);

    TextSpan rightTextSpan = TextSpan(
        text: title,
        // style: AppTextStyle.bold64.copyWith(color: Colors.orange, backgroundColor: Colors.black, fontSize: 70));
        style: TextStyle(
            fontSize: textSize, color: Colors.orange, fontWeight: FontWeight.bold, backgroundColor: Colors.black));
    final rightTextPainter = TextPainter()
      ..text = rightTextSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();

    double rightTextOffsetX = -rightTextPainter.height + 9;
    double rightTextOffsetY = -80 - 1000 * progress;

    canvas.translate(
        textPainter.width / 2 + rightTextOffsetX + xCenter, textPainter.height / 2 + rightTextOffsetY + yCenter);
    canvas.rotate(pi / 2);
    canvas.translate(
        -(textPainter.width / 2 + rightTextOffsetX + xCenter), -(textPainter.height / 2 + rightTextOffsetY + yCenter));

    rightTextPainter.paint(canvas, Offset(rightTextOffsetX, rightTextOffsetY));
    canvas.restore();

    ///가운데 사라지는거
    canvas.saveLayer(Rect.largest, Paint());

    double centerMaxWidth = 30.0;
    centerMaxWidth -= centerMaxWidth * progress;

    final rectPaint = Paint();
    rectPaint.color = Colors.black;
    rectPaint.style = PaintingStyle.fill;

    final centerRect = Rect.fromLTWH(size.width / 2 - centerMaxWidth / 2, 0, centerMaxWidth, size.height);
    canvas.drawRect(centerRect, rectPaint);

    ///양 옆 사라지는거

    double sideMaxWidth = 15.0;
    sideMaxWidth -= sideMaxWidth * progress;

    final leftRectPaint = Paint();
    leftRectPaint.color = Colors.black;
    leftRectPaint.style = PaintingStyle.fill;

    final leftRect = Rect.fromLTWH(0, 0, sideMaxWidth, size.height);
    canvas.drawRect(leftRect, leftRectPaint);

    final rightRectPaint = Paint();
    rightRectPaint.color = Colors.black;
    leftRectPaint.style = PaintingStyle.fill;

    final rightRect = Rect.fromLTWH(size.width - sideMaxWidth, 0, sideMaxWidth, size.height);
    canvas.drawRect(rightRect, rightRectPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
