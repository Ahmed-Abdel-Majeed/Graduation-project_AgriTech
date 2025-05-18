// Created by [Ahmed] on [18/4/2025].
import 'package:flutter/material.dart';

class SplashAnimationController {
  final TickerProvider vsync;
  late final AnimationController controller;
  late final Animation<double> logoVerticalOffset;
  late final Animation<double> textOpacity;
  late final Animation<double> finalOffsetX;

  SplashAnimationController({required this.vsync}) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 4),
    );

    logoVerticalOffset = Tween<double>(begin: 2.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.3, curve: Curves.easeOutBack)),
    );

    textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 0.7, curve: Curves.easeIn)),
    );

    finalOffsetX = Tween<double>(begin: -25.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.7, 1.0, curve: Curves.easeInOut)),
    );
  }

  void dispose() {
    controller.dispose();
  }
}
