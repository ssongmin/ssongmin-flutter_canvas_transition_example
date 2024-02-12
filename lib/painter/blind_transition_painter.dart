import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class BlindTransitionPainter extends CustomProgressPainter {
  @override
  String get title => 'BlindTransition';

  final double textHeight = 35;
  final double hideHeight = 30;
  final double textSize = 30;

  /// 지워지는 효과 시작
  final startProgress = 0.5;

  BlindTransitionPainter({required super.progress, required super.text});

  @override
  void paint(Canvas canvas, Size size) async {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.black;
    canvas.drawRect(fullRect, backgroundPaint);

    ///Text
    ///TODO 폰트찾기
    // TextSpan textSpan = TextSpan(text: text, style: AppTextStyle.bold30white);
    TextSpan textSpan = TextSpan(text: text, style: TextStyle(fontSize: textSize, color: Colors.white));
    final textPainter = TextPainter()
      ..text = textSpan
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();
    textPainter.paint(canvas, const Offset(0, 0));
    int totalLength = 0;
    for (int i = 0; i < size.height; i += (textHeight.toInt())) {
      textPainter.paint(canvas, Offset(0, i.toDouble()));
      totalLength++;
    }

    ///나타나는 애니메이션
    ///5세트가 1이라고 보는걸로 하면 될거같음 어떻게???!
    for (int i = 0; i < size.height; i += (textHeight.toInt())) {
      int index = i ~/ textHeight + 1;

      double minProgress = index / totalLength;
      double maxProgress = ((index + 1) / totalLength) * 2;

      final progress = this.progress * 3;

      Paint textEraserPaint = Paint();
      textEraserPaint.color = Colors.black;

      if (minProgress <= progress && maxProgress >= progress) {
        ///위에서 아래 내려 오는 효과
        Rect testRect = Rect.fromLTRB(0, i + textHeight * (progress - minProgress) / (maxProgress - minProgress),
            size.width, (i + textHeight).toDouble());

        canvas.drawRect(testRect, textEraserPaint);
      } else if (progress > maxProgress) {
        ///반대로 줄어야 함

        /// 하나씩 줄어 효과
        // Rect testRect = Rect.fromLTWH(0, i.toDouble(), size.width,
        //     textHeight * min(1, max((progress / 3 - minProgress) / (maxProgress / 2 - minProgress), 0)));

        ///여러개 동시에 줄어 드는 효과
        Rect testRect = Rect.fromLTWH(0, i.toDouble(), size.width, textHeight * (progress - maxProgress) * 2);

        canvas.drawRect(testRect, textEraserPaint);
      } else {
        Rect testRect = Rect.fromLTWH(0, (i).toDouble(), size.width, textHeight);
        canvas.drawRect(testRect, textEraserPaint);
      }
    }

    /// 지워지는 효과
    for (int i = 0; i < size.height; i += (hideHeight.toInt())) {
      int index = i ~/ hideHeight + 1;

      double progress = this.progress * 2;

      if (progress < startProgress) {
        break;
      }
      progress = progress - startProgress;

      int totalLength = size.height ~/ hideHeight;

      double minProgress = (index / totalLength);
      double maxProgress = ((index + 1) / totalLength) * 2;

      Paint eraserPaint = Paint();
      eraserPaint.blendMode = BlendMode.clear;
      eraserPaint.style = PaintingStyle.fill;

      if (minProgress <= progress && maxProgress >= progress) {
        Rect testRect =
            Rect.fromLTWH(0, i.toDouble(), size.width, min(30, hideHeight * (progress / (index / totalLength) - 1)));

        canvas.drawRect(testRect, eraserPaint);
      } else if (progress >= maxProgress) {
        Rect testRect = Rect.fromLTWH(0, i.toDouble(), size.width, hideHeight);
        canvas.drawRect(testRect, eraserPaint);
      } else {}
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
