import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 650) {
      return desktop;
    } else if (width < 650) {
      return mobile;
    } else {
      return mobile;
    }
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 650;
  } 
}
