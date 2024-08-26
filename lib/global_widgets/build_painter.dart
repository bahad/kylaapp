import 'package:flutter/material.dart';
import 'package:kyla/features/home_controller.dart';
import 'dart:math' as math;
import '../core/constants/app_colors.dart';

class BuildLinesPainter extends CustomPainter {
  BuildLinesPainter(this.controller, this.centerY);
  final HomeController? controller;
  final double? centerY;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final linesCount = (controller!.list.length - 1) * 5 + 1;

    final paddingTop = controller!.paddingTopInPercentage * height / 100 + controller!.kNumberFontSize / 2;
    final paddingBottom =
        controller!.paddingBottomInPercentage * height / 100 + controller!.kNumberFontSize / 2;

    final oneLineStep = (height - paddingTop - paddingBottom) / (linesCount - 1);
    var y = paddingTop;
    var path = Path();

    for (var i = 0; i < linesCount; i++) {
      var isLong = i % 5 == 0;
      var startX = isLong ? 22.0 : 29.0;
      var endX = width;
      var fix = 23; // don't know why do I need it. 😅
      var distanceTillCenter = (y - centerY! - fix).abs();
      if (distanceTillCenter < 50) {
        var sin = distanceTillCenter / 50;
        var angle = math.asin(sin);
        var cos = math.cos(angle);
        var delta = 30 * cos * cos * 1.05;
        startX -= delta;
        endX -= delta;
      }
      path
        ..moveTo(startX, y)
        ..lineTo(endX, y);

      y += oneLineStep;
    }

    var paint = Paint()
      ..color = AppColors.gray2
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
