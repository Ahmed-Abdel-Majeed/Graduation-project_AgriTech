import 'package:flutter/material.dart';

class SplashLogoWithText extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> logoVerticalOffset;
  final Animation<double> textOpacity;
  final Animation<double> finalOffsetX;

  const SplashLogoWithText({
    super.key,
    required this.controller,
    required this.logoVerticalOffset,
    required this.textOpacity,
    required this.finalOffsetX,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final logoSize = isTablet ? 200.0 : 120.0;
    final fontSize = isTablet ? 32.0 : 20.0;

    return Center(
      child: Transform.translate(
        offset: Offset(finalOffsetX.value, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.translate(
              offset: Offset(0, screenHeight * logoVerticalOffset.value),
              child: SizedBox(
                width: logoSize,
                height: logoSize,
                child: Image.asset("assets/images/logo.png", fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 16),
            Opacity(
              opacity: textOpacity.value,
              child: Text(
                'Agri Tech X',
                style: TextStyle(
                  // fontFamily: 'Orbitron',
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
