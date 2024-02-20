import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class OverlapTextMoveTransitionPainter extends CustomProgressPainter {
  @override
  String get title => 'OverlapTextMoveTransition';

  final double textHeight = 35;
  final double textSize = 32;

  OverlapTextMoveTransitionPainter({required super.progress, required super.text});

  /// progress 0 -> 0.5 텍스트 채워짐
  /// 0.5 -> 1 스케일???
  @override
  void paint(Canvas canvas, Size size) async {
    // canvas.saveLayer(Rect.largest, Paint());
    final progress = Curves.decelerate.transformInternal(this.progress);

    Curves.decelerate;
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(fullRect);

    if (progress >= 0.5) {
      canvas.translate(size.width / 2, size.height / 2);
      canvas.scale(min(2.5, 1 + 8 * (progress - 0.5)));
      canvas.translate(-size.width / 2, -size.height / 2);
    }

    ///Text Painter
    TextSpan textSpan = TextSpan(
        text: text,
        // style: AppTextStyle.bold24
        //     .copyWith(backgroundColor: Colors.deepOrange, overflow: TextOverflow.clip, fontSize: 30));
        style: TextStyle(
            fontSize: textSize,
            backgroundColor: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip));

    final textPainter = TextPainter()
      ..text = textSpan
      ..maxLines = 1
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();
    // ..layout(maxWidth: 500 * progress);

    final textWidth = textPainter.size.width;
    final textHeight = textPainter.size.height;

    ///겹치는 정도
    const textOverlapHeight = 12;

    const falls = 0.1;

    for (int i = 0; i < size.height / (textHeight - textOverlapHeight) / 2; i++) {
      canvas.saveLayer(Rect.largest, Paint());
      Rect fullRect = Rect.fromLTWH(0, 0, size.width * max(0, progress + (i * falls)), size.height);
      canvas.clipRect(fullRect);

      textPainter.paint(
          canvas, Offset(size.width / 2 - textWidth / 2 + i * progress * 6, (textHeight - textOverlapHeight) * i));

      textPainter.paint(
          canvas,
          Offset(size.width / 2 - textWidth / 2 + i * progress * 6,
              (textHeight - textOverlapHeight) * ((size.height / (textHeight - textOverlapHeight)) - i)));

      canvas.restore();
    }
    canvas.saveLayer(Rect.largest, Paint());

    // Rect centerRect = Rect.fromLTWH(0, 0, size.width * max(0, progress), size.height);
    // canvas.clipRect(centerRect);
    // textPainter.paint(canvas, Offset(size.width / 2 - textWidth / 2, size.height / 2 - textHeight / 2));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
