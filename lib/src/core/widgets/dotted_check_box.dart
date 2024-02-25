import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schmitt/src/core/utils/theme/app_colors/app_colors.dart';

class DottedCirclePainter extends CustomPainter {
  final bool isChecked;

  DottedCirclePainter({required this.isChecked});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkBlue
      ..strokeWidth = 1 
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    const step = pi / 30; 
    for (var i = 0.0; i < 2 * pi; i += step) {
      final x = center.dx + radius * cos(i);
      final y = center.dy + radius * sin(i);
      canvas.drawCircle(Offset(x, y), 1, paint); 
    }

    if (isChecked) {
      canvas.drawCircle(center, radius - 4, Paint()..color = AppColors.darkBlue);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}