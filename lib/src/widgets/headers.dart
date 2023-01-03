import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(painter: _LoginPersonalizado()),
    );
  }
}

class _LoginPersonalizado extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.blueGrey[800]!;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 20;

    final path = Path();

    // path.lineTo(0, size.height * 0.32);
    // path.quadraticBezierTo(size.width * 0.05, size.height * 0.375,
    //     size.width * 0.18, size.height * 0.35);
    // //path.lineTo(size.width * 0.15, size.height * 0.25);
    // path.lineTo(size.width, size.height * 0.16);
    // path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.04, size.height * 0.6,
        size.width * 0.39, size.height * 0.59);
    //path.lineTo(size.width * 0.15, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
