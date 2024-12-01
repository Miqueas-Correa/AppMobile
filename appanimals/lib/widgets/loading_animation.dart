import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  final Duration duration;

  const LoadingAnimation(
      {super.key, this.duration = const Duration(seconds: 2)});

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _colorController;
  bool _showAnimation = true;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _colorController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          _showAnimation = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _showAnimation
        ? Center(
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationController.value *
                      2.0 *
                      3.14159, // Completa una rotación
                  child: AnimatedBuilder(
                    animation: _colorController,
                    builder: (context, child) {
                      return CustomPaint(
                        size: Size(100, 100),
                        painter:
                            _LoadingPainter(progress: _colorController.value),
                      );
                    },
                  ),
                );
              },
            ),
          )
        : Container();
  }
}

class _LoadingPainter extends CustomPainter {
  final double progress;

  _LoadingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBackground = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final Paint paintProgress = Paint()
      ..shader = RadialGradient(
        colors: [Colors.blue, Colors.green],
        stops: [0.3, 1.0],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2))
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2,
        paintBackground);
    double sweepAngle = 2 * 3.14159 * progress;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        -3.14159 / 2,
        sweepAngle,
        false,
        paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
