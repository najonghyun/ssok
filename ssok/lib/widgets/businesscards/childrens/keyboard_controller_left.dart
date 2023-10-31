import 'package:flutter/material.dart';
import 'dart:async';

class KeyboardControllerLeft extends StatefulWidget {
  final double dx;
  final double dy;
  final Function(double, double) onDirectionChanged;

  const KeyboardControllerLeft({
    Key? key,
    required this.dx,
    required this.dy,
    required this.onDirectionChanged,
  }) : super(key: key);

  @override
  State<KeyboardControllerLeft> createState() => _KeyboardControllerLeftState();
}

class _KeyboardControllerLeftState extends State<KeyboardControllerLeft> {
  double newDx = 0;
  double newDy = 0;
  Timer? longPressTimer;
  late double maxWidth;
  late double maxHeight;

  @override
  void initState() {
    super.initState();
    // 화면의 최대 너비와 높이를 가져옵니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      maxWidth = MediaQuery.of(context).size.width * 0.54;
      maxHeight = MediaQuery.of(context).size.height * 0.16;
    });
  }

  void startMoving() {
    longPressTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      newDx = (widget.dx - 1).clamp(0, maxHeight);
      newDy = widget.dy; // 왼쪽으로 10 이동
      widget.onDirectionChanged(newDx, newDy);
    });
  }

  void stopMoving() {
    longPressTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        newDx = (widget.dx - 1).clamp(0, maxHeight);
        newDy = widget.dy;
        widget.onDirectionChanged(newDx, newDy);
      },
      onTapDown: (details) {
        startMoving();
      },
      onTapUp: (details) {
        stopMoving();
      },
      onTapCancel: () {
        stopMoving();
      },
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        child: Icon(
          Icons.west,
          size: 30,
        ),
      ),
    );
  }
}
