import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/main/presentation/welcome/logic/splash_animation_controller.dart';
import 'package:agri/features/main/presentation/welcome/widgets/splash_logo_with_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late SplashAnimationController splashAnimation;

  @override
  void initState() {
    super.initState();
    splashAnimation = SplashAnimationController(vsync: this);
    splashAnimation.controller.forward();

    splashAnimation.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushNamed(context, AppRoutes.welcome);
        });
      }
    });
  }

  @override
  void dispose() {
    splashAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: splashAnimation.controller,
        builder: (context, _) {
          return SplashLogoWithText(
            controller: splashAnimation.controller,
            logoVerticalOffset: splashAnimation.logoVerticalOffset,
            textOpacity: splashAnimation.textOpacity,
            finalOffsetX: splashAnimation.finalOffsetX,
          );
        },
      ),
    );
  }
}
