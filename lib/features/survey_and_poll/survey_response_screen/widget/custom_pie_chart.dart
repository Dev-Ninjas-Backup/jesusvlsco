import 'package:flutter/material.dart';
import 'dart:math';

class CustomPieChart extends StatelessWidget {
  final double? size;
  final double? strokeWidth;
  final List<RingSegment>? segments;

  const CustomPieChart({
    super.key,
    this.size,
    this.strokeWidth,
    this.segments,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size ?? 200, size ?? 200),
      painter: RingPainter(
        strokeWidth: strokeWidth ?? 30.0,
        segments: segments ??
            [
              RingSegment(color: Colors.green, fraction: 0.25),
              RingSegment(color: Colors.brown, fraction: 0.15),
              RingSegment(color: Colors.blue, fraction: 0.30),
              RingSegment(color: Colors.orange, fraction: 0.20),
              RingSegment(color: Colors.purple, fraction: 0.10),
            ],
      ),
    );
  }
}

class RingSegment {
  final Color color;
  final double fraction;

  RingSegment({required this.color, required this.fraction});
}

class RingPainter extends CustomPainter {
  final double strokeWidth;
  final List<RingSegment> segments;

  RingPainter({required this.strokeWidth, required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    double startAngle = -pi / 2;

    for (var segment in segments) {
      final sweepAngle = 2 * pi * segment.fraction;
      paint.color = segment.color;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
