import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class PassScreenTransitionPainter extends CustomProgressPainter {
  @override
  String get title => 'PassScreenTransition';

  PassScreenTransitionPainter({required super.progress, required super.text});

  final double textSize = 30;

  ///5개가 오버레이 되어있음 (고정되어있음)
  ///아래에 있는 친구부터 그려줘야함

  /// TODO 동적으로 오버레이 개수 받는걸로 변경
  @override
  void paint(Canvas canvas, Size size) async {
    // canvas.saveLayer(Rect.largest, Paint());

    int page = 4;
    double draw1Progress1 = 0;
    double draw1Progress2 = 0;
    double draw1Progress3 = 0;
    double draw1Progress4 = 0;

    if (progress >= 0 && progress <= 1 / page) {
      draw1Progress1 = progress * page;
    } else if (progress > 1 / page) {
      draw1Progress1 = 1;
    }
    if (progress >= 1 / page && progress <= 2 / page) {
      draw1Progress2 = (progress - 1 / page) * page;
    } else if (progress > 2 / page) {
      draw1Progress2 = 1;
    }
    if (progress >= 2 / page && progress <= 3 / page) {
      draw1Progress3 = (progress - 2 / page) * page;
    } else if (progress > 3 / page) {
      draw1Progress3 = 1;
    }
    if (progress >= 3 / page && progress <= 4 / page) {
      draw1Progress4 = (progress - 3 / page) * page;
    } else if (progress > 4 / page) {
      draw1Progress4 = 1;
    }

    draw4(canvas, draw1Progress4, text, size);
    draw3(canvas, draw1Progress3, text, size);
    draw2(canvas, draw1Progress2, text, size);
    draw1(canvas, draw1Progress1, text, size);
  }

  void draw4(Canvas canvas, double progress, String text, Size size) {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.green;
    canvas.drawRect(fullRect, backgroundPaint);

    // TextSpan textSpan = TextSpan(text: text, style: AppTextStyle.bold24.copyWith(fontSize: 30, color: Colors.blue));
    TextSpan textSpan =
        TextSpan(text: text, style: TextStyle(fontSize: textSize, color: Colors.blue, fontWeight: FontWeight.bold));

    final textPainter = TextPainter()
      ..text = textSpan
      ..maxLines = 1
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 - textPainter.height / 2));

    Paint eraserPaint = Paint();
    eraserPaint.blendMode = BlendMode.clear;
    eraserPaint.style = PaintingStyle.fill;

    final overlapHeight = size.height + 200;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - overlapHeight * progress);
    path.lineTo(0, size.height + 200 - overlapHeight * progress);
    path.moveTo(0, size.height);
    path.close();

    canvas.drawPath(path, eraserPaint);

    canvas.restore();
  }

  void draw3(Canvas canvas, double progress, String text, Size size) {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.blue;
    canvas.drawRect(fullRect, backgroundPaint);

    TextSpan textSpan =
        // TextSpan(text: text, style: AppTextStyle.bold24.copyWith(fontSize: 30, color: Colors.amberAccent));
        TextSpan(
            text: text, style: TextStyle(fontSize: textSize, color: Colors.amberAccent, fontWeight: FontWeight.bold));

    final textPainter = TextPainter()
      ..text = textSpan
      ..maxLines = 1
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 - textPainter.height / 2));

    Paint eraserPaint = Paint();
    eraserPaint.blendMode = BlendMode.clear;
    eraserPaint.style = PaintingStyle.fill;

    final overlapHeight = size.height + 200;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - overlapHeight * progress);
    path.lineTo(0, size.height + 200 - overlapHeight * progress);
    path.moveTo(0, size.height);
    path.close();

    canvas.drawPath(path, eraserPaint);

    canvas.restore();
  }

  void draw2(Canvas canvas, double progress, String text, Size size) {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.amberAccent;
    canvas.drawRect(fullRect, backgroundPaint);

    TextSpan textSpan =
        // TextSpan(text: text, style: AppTextStyle.bold24.copyWith(fontSize: 30, color: Colors.redAccent));
        TextSpan(
            text: text, style: TextStyle(fontSize: textSize, color: Colors.redAccent, fontWeight: FontWeight.bold));

    final textPainter = TextPainter()
      ..text = textSpan
      ..maxLines = 1
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center
      ..layout();
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 - textPainter.height / 2));

    Paint eraserPaint = Paint();
    eraserPaint.blendMode = BlendMode.clear;
    eraserPaint.style = PaintingStyle.fill;

    final overlapHeight = size.height + 200;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - overlapHeight * progress);
    path.lineTo(0, size.height + 200 - overlapHeight * progress);
    path.moveTo(0, size.height);
    path.close();

    canvas.drawPath(path, eraserPaint);

    canvas.restore();
  }

  void draw1(Canvas canvas, double progress, String text, Size size) {
    canvas.saveLayer(Rect.largest, Paint());

    /// Background
    Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.redAccent;
    canvas.drawRect(fullRect, backgroundPaint);

    Paint eraserPaint = Paint();
    eraserPaint.blendMode = BlendMode.clear;
    eraserPaint.style = PaintingStyle.fill;

    final overlapHeight = size.height + 200;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - overlapHeight * progress);
    path.lineTo(0, size.height + 200 - overlapHeight * progress);
    path.moveTo(0, size.height);
    path.close();

    canvas.drawPath(path, eraserPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
