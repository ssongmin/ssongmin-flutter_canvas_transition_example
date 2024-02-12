import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';

class PainterShowPage extends StatefulWidget {
  final CustomProgressPainter customProgressPainter;

  const PainterShowPage({required this.customProgressPainter, super.key});

  @override
  State<PainterShowPage> createState() => _PainterShowPageState();
}

class _PainterShowPageState extends State<PainterShowPage> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customProgressPainter.title),
      ),
      body: Column(
        children: [
          ///TODO Size조절 하나만 쓸수 있음
          CustomPaint(
            foregroundPainter: widget.customProgressPainter,

            /// 화면 세로 길이의 4/10 고정, 9:16(가로:세로) 비율 고정
            size: Size(screenSize.height * 4 / 10 * 9 / 16, screenSize.height * 4 / 10),
            child: SizedBox(
              width: screenSize.height * 4 / 10 * 9 / 16,
              height: screenSize.height * 4 / 10,
              child: Image.asset("assets/nwjns.jpeg"),
            ),
          ),

          Slider(
            value: widget.customProgressPainter.progress,
            onChanged: (value) {
              setState(() {
                // progress = value;
                widget.customProgressPainter.changeProgress(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
