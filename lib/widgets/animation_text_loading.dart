import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingTextAnimation extends StatefulWidget {
  @override
  _LoadingTextAnimationState createState() => _LoadingTextAnimationState();
}

class _LoadingTextAnimationState extends State<LoadingTextAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(); // chạy lặp vô tận
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        width: 235,
        height: 70,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [
                      (_controller.value - 0.3).clamp(0.0, 1.0),
                      _controller.value.clamp(0.0, 1.0),
                      (_controller.value + 0.3).clamp(0.0, 1.0),
                    ],
                    colors: [
                      Colors.white.withOpacity(0.2), // Mờ
                      Colors.white,                  // Đậm
                      Colors.white.withOpacity(0.2), // Mờ
                    ],
                  ).createShader(bounds);
                },
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 0.0), // Độ nhòe
                  child: Text(
                    "[Developer: Hồ Ngọc Hòa   ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5), // Base color (bị shader đè lên)
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
