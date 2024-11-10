// import 'package:flutter/material.dart';
// import 'package:path_drawing/path_drawing.dart';

// class DottedBorderPainter extends CustomPainter {
//   final Color color;
//   final double strokeWidth;

//   DottedBorderPainter({required this.color, required this.strokeWidth});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;

//     final path = Path()
//       ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

//     final dashPath = dashPath(
//       path,
//       dashArray: CircularIntervalList<double>(<double>[5.0, 5.0]),
//     );

//     canvas.drawPath(dashPath, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
