import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../config/routes/app_routes.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool showAppBar;
  final bool useResponsivePadding;
  final String? title;

  const MainLayout({
    super.key,
    required this.child,
    this.showAppBar = false,
    this.title,
    this.useResponsivePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    final body =
        useResponsivePadding
            ? ScreenTypeLayout.builder(
              mobile: (_) => _buildPadded(child, 10),
              tablet: (_) => _buildPadded(child, 100),
              desktop:
                  (_) => _buildPadded(
                    child,
                    MediaQuery.of(context).size.width * 0.2,
                  ),
            )
            : child;

    return Scaffold(
      appBar:
          showAppBar
              ? AppBar(
                leading: const Icon(Icons.agriculture,),
                title: const Text('Smart Farm Dashboard'),
                iconTheme: const IconThemeData(color: Colors.black),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    tooltip: 'Home',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.home);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.analytics),
                    tooltip: 'Hydroponic Dashboard',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.hydroponicDashboardWeb,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    tooltip: 'Scan',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.cropScanPage);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_filter),
                    tooltip: 'Photos',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.plantMonitoringPage,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    tooltip: 'hydroponicsControlPage',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.hydroponicsControlPage);
                    },
                  ),
                ],
              )
              : null,
      body: body,
    );
  }

  Widget _buildPadded(Widget child, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
      child: child,
    );
  }
}
