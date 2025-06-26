import 'package:agri/features/About/about_page.dart';
import 'package:agri/features/ai_scan_analysis/plan_scan_ai_screen.dart';
import 'package:agri/features/plant_analysis/screens/plant_analysis_screen.dart';
import 'package:agri/features/auth/presentation/pages/login_screen.dart';
import 'package:agri/features/auth/presentation/pages/register_screen.dart';
import 'package:agri/features/chat_bot/screens/chat_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/farm_dashboard.dart';
import 'package:agri/features/home/presentation/screens/ai_analysis.dart';
import 'package:agri/features/main/presentation/screens/main_screen.dart';
import 'package:agri/features/profile/profile_screen.dart';
import 'package:agri/features/welcome/screens/splash_screen.dart.dart';
import 'package:agri/features/welcome/screens/welcome_screen.dart';
import 'package:agri/ui/widgets/home_screen.dart';
import 'package:flutter/material.dart';


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
  static const String aiAnalysis = "/aiAnalysis";
  static const String chatScreen = "/chatScreen";
  static const String mainFarmScreen = "/mainFarmScreen";
  static const String farmdashboard = "/mainFarmScreen";
  static const String farmAnalysisScreen = "/farmAnalysisScreen";
    static const String farmAnalysisHome = '/farm-analysis';
  static const String farmAnalysisSummary = '/farm-analysis/summary';
  static const String farmAnalysisDetail = '/farm-analysis/detail';
  static const String plantAnalysisScreen = '/plantAnalysisScreen';
  static const String planScanAi = '/planScanAi';
  static const String profilePage = '/profilePage';
  static const String aboutPage  = '/aboutPage';



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
      case mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
              case aboutPage:
        return MaterialPageRoute(builder: (_) => AboutPage ());

  
      case welcome:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case farmdashboard:
        final args = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => FarmDashboard(index: args));
      case planScanAi:
        
        return MaterialPageRoute(builder: (_) => PlanScanAi());

      case plantAnalysisScreen:
        return MaterialPageRoute(builder: (_) => const PlantAnalysisScreen());
      case chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case aiAnalysis:
        return MaterialPageRoute(builder: (_) => const AiAnalysis());
              case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());



      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
