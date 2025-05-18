import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double borderRadius;
  final IconData? icon;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderRadius = 15,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // الحصول على إعدادات الثيم
    final theme = Theme.of(context);
    final buttonColor = color ?? theme.colorScheme.primary;
    final buttonTextColor = textColor ?? Colors.white;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.77,
      height: screenHeight * (48 / 900), 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) Icon(icon, color: buttonTextColor),
            if (icon != null) const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: buttonTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
