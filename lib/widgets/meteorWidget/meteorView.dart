import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:math';

import 'package:spaceandplanets_app/widgets/meteorWidget/meteorState.dart';

class MeteorWidget extends ConsumerStatefulWidget {
  final int numberOfMeteors;
  final Duration duration;
  final Widget child;

  const MeteorWidget({
    super.key,
    required this.child,
    this.numberOfMeteors = 10,
    this.duration = const Duration(seconds: 5),
  });

  @override
  _MeteorWidgetState createState() => _MeteorWidgetState();
}

class _MeteorWidgetState extends ConsumerState<MeteorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final meteors = ref.watch(meteorProvider(size));

        return Stack(
          children: [
            widget.child,
            ...meteors.map((meteor) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final progress = ((_controller.value - meteor.delay) % 1.0) /
                      meteor.duration;
                  if (progress < 0 || progress > 1) return const SizedBox.shrink();

                  return Positioned(
                    left: meteor.startX +
                        (meteor.endX - meteor.startX) * progress,
                    top: meteor.startY +
                        (meteor.endY - meteor.startY) * progress,
                    child: Opacity(
                      opacity: (1 - progress) * 0.8,
                      child: Transform.rotate(
                        angle: 315 * (pi / 180),
                        child: CustomPaint(
                          size: const Size(2, 20),
                          painter: MeteorPainter(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        );
      },
    );
  }
}

// 🌠 Meteor Çizimi
class MeteorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint trailPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.white.withOpacity(0)],
        end: Alignment.topCenter,
        begin: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), trailPaint);

    final Paint circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height), 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
