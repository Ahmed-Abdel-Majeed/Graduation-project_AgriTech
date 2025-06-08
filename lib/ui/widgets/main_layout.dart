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
    final theme = Theme.of(context);
    final body = useResponsivePadding
        ? ScreenTypeLayout.builder(
            mobile: (_) => _buildPadded(child, 16),
            tablet: (_) => _buildPadded(child, 100),
            desktop: (_) => _buildPadded(
                  child,
                  MediaQuery.of(context).size.width * 0.2,
                ),
          )
        : child;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: showAppBar
          ? AppBar(
              elevation: 2,
              backgroundColor: theme.colorScheme.surface,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.agriculture,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
              title: Text(
                'Smart Farm Dashboard',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                _buildAppBarAction(
                  context,
                  Icons.home_rounded,
                  'Home',
                  () => Navigator.pushNamed(context, AppRoutes.home),
                ),
                _buildAppBarAction(
                  context,
                  Icons.analytics_rounded,
                  'Hydroponic Dashboard',
                  () => Navigator.pushNamed(
                    context,
                    AppRoutes.hydroponicDashboardWeb,
                  ),
                ),
                _buildAppBarAction(
                  context,
                  Icons.camera_alt_rounded,
                  'Scan',
                  () => Navigator.pushNamed(context, AppRoutes.cropScanPage),
                ),
                _buildAppBarAction(
                  context,
                  Icons.photo_filter_rounded,
                  'Photos',
                  () => Navigator.pushNamed(
                    context,
                    AppRoutes.plantMonitoringPage,
                  ),
                ),
                _buildAppBarAction(
                  context,
                  Icons.settings_rounded,
                  'Hydroponics Control',
                  () => Navigator.pushNamed(context, AppRoutes.hydroponicsControlPage),
                ),
              ],
            )
          : null,
      body: body,
    );
  }

  Widget _buildAppBarAction(
    BuildContext context,
    IconData icon,
    String tooltip,
    VoidCallback onPressed,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: IconButton(
        icon: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        tooltip: tooltip,
        onPressed: onPressed,
        style: IconButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          hoverColor: theme.colorScheme.primary.withOpacity(0.1),
        ),
      ),
    );
  }

  Widget _buildPadded(Widget child, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 24),
      child: child,
    );
  }
}
