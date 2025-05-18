import 'package:agri/features/chat_bot/screens/chat_screen.dart';
import 'package:agri/presentation/dashboard/screens/sensors_dashboard.dart';
import 'package:agri/ui/widgets/app_navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final String? location;
  const MainScreen({super.key, this.location});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb?null: AppBar(
        title: const Text('Sensor Dashboard'),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppNavigator.push(context, const ChatScreen()),
        child: Image.asset("assets/images/aichat.png"),
      ),
      backgroundColor: Colors.white,
      body: SensorsDashboard(
                
              ),
              
  );
  }
}
