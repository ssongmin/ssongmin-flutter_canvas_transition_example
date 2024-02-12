import 'package:flutter/material.dart';

abstract class CustomProgressPainter extends CustomPainter {
  double progress;
  String text;

  String get title;

  CustomProgressPainter({required this.progress, required this.text});

  void changeProgress(double progress) {
    this.progress = progress;
  }
}
