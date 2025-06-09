import 'package:agri/features/camera/screens/crop_scan_page.dart';
import 'package:agri/features/auth/presentation/pages/login_screen.dart';
import 'package:agri/features/auth/presentation/pages/register_screen.dart';
import 'package:agri/features/chat_bot/screens/chat_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/main_farm_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/farm_dashboard.dart';
import 'package:agri/features/main/presentation/dashboard/screens/humidity_dashboard_screen.dart';
import 'package:agri/features/main/presentation/dashboard/screens/hydropoinc_dashboard_screen.dart';
import 'package:agri/features/main/presentation/dashboard/screens/temperature_dashboard_screen.dart';
import 'package:agri/features/main/presentation/main/screens/main_screen.dart';
import 'package:agri/features/main/presentation/welcome/screens/splash_screen.dart.dart';
import 'package:agri/features/main/presentation/welcome/screens/welcome_screen.dart';
import 'package:agri/ui/widgets/home_screen.dart';
import 'package:flutter/material.dart';

import '../../features/main/presentation/dashboard/screens/plant_monitoring_page.dart'
    show PlantMonitoringPage;

class AppRoutes {
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String register = "/register";
  static const String home = "/home";
  static const String splash = "/splash";
  static const String mainScreen = "/mainScreen";
  static const String temperatureChartScreen = "/temperatureChartScreen";
  static const String humidityChartScreen = "/humidityChartScreen";
  static const String hydroponicsControlPage = "/hydroponicsControlPage";
  static const String plantMonitoringPage = "/plantMonitoringPage";
  static const String cropScanPage = "/cropScanPage";
  static const String hydropoincDashboardScreen = "/hydropoincDashboardScreen";
  static const String sensorDashboardPage = "/sensorDashboardPage";
  static const String sensorDashboardWebPage = "/sensorDashboardWebPage";
  static const String sensorDashboardMobilePage = "/sensorDashboardMobilePage";
  static const String hydroponicDashboard = "/hydroponicDashboard";
  static const String hydroponicDashboardWeb = "/hydroponicDashboardWeb";
  static const String chatScreen = "/chatScreen";
  static const String mainFarmScreen = "/mainFarmScreen";
  static const String farmdashboard = "/mainFarmScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(
          builder:
              (_) => const HomeScreen(), // Use HomeScreen for the home route
        );
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case temperatureChartScreen:
        return MaterialPageRoute(builder: (_) => TemperatureChartScreen());
      case humidityChartScreen:
        return MaterialPageRoute(builder: (_) => HumidityChartScreen());
      case welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case farmdashboard:
        final args = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => FarmDashboard(index: args));

      case plantMonitoringPage:
        return MaterialPageRoute(builder: (_) => const PlantMonitoringPage());
      case cropScanPage:
        return MaterialPageRoute(builder: (_) => const CropScanPage());
      case chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case hydroponicDashboard:
        return MaterialPageRoute(builder: (_) => const HydroponicDashboard());

      case mainFarmScreen:
        return MaterialPageRoute(builder: (_) => const MainFarmScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
