import 'package:agri/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'welcome_image.dart';
import 'welcome_text.dart';
import 'welcome_button.dart';

class WelcomeBody extends StatelessWidget {
  final Size screenSize;

  const WelcomeBody({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WelcomeImage(screenSize: screenSize),
        const SizedBox(height: 20),
        const WelcomeText(),
        const SizedBox(height: 22),
        WelcomeButton(onPressed: () => _showCustomDialog(context)),
      ],
    );
  }

  void _showCustomDialog(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    showDialog(
    
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: width>600?width * 0.5:width ,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Text(
                  'Choose an option',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
