import 'package:flutter/material.dart';
import 'package:flutter_canvas_transition_example/painter/blind_transition_painter.dart';
import 'package:flutter_canvas_transition_example/painter/custom_progress_painter.dart';
import 'package:flutter_canvas_transition_example/painter/overlap_text_move_transition_painter.dart';
import 'package:flutter_canvas_transition_example/painter/pass_screen_transition_painter.dart';
import 'package:flutter_canvas_transition_example/painter/scale_text_mask_transition_painter.dart';
import 'package:flutter_canvas_transition_example/painter/section_move_transition_painter.dart';
import 'package:flutter_canvas_transition_example/painter/text_move_transition_painter.dart';
import 'package:flutter_canvas_transition_example/painter_show_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Canvas Transition Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          painterButton(customProgressPainter: BlindTransitionPainter(progress: 0, text: 'Test123456')),
          painterButton(customProgressPainter: ScaleTextMaskTransitionPainter(progress: 0, text: '12')),
          painterButton(customProgressPainter: TextMoveTransitionPainter(progress: 0, text: 'Test123456')),
          painterButton(customProgressPainter: PassScreenTransitionPainter(progress: 0, text: 'Test123456')),
          painterButton(customProgressPainter: SectionMoveTransitionPainter(progress: 0, text: 'Test123456')),
          painterButton(customProgressPainter: OverlapTextMoveTransitionPainter(progress: 0, text: 'Test123456')),
        ],
      ),
    );
  }

  Widget painterButton({required CustomProgressPainter customProgressPainter}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PainterShowPage(
              customProgressPainter: customProgressPainter,
            ),
          ),
        );
      },
      child: Text(customProgressPainter.title),
    );
  }
}
