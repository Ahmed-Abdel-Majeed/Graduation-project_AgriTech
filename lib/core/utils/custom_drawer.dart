import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/welcome/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Agri TechX',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(color: Colors.black26, fontSize: 14),
                ),
              ],
            ),

            const SizedBox(height: 30),

            drawerItem(
              icon: Icons.person,
              label: 'Profile',
              onTap: () {
                Navigator.pop(context); // اغلق الدروار
                Navigator.pushNamed(context, AppRoutes.profilePage);
              },
            ),
            drawerItem(
              icon: Icons.info_outline,
              label: 'About',
              onTap: () {
                Navigator.pop(context); // اغلق الدروار
                Navigator.pushNamed(context, AppRoutes.aboutPage);
              },
            ),

            const SizedBox(height: 30),

            // بدل Spacer استخدم Expanded إذا فعلاً محتاجه
            Expanded(child: Container()),

            drawerItem(
              icon: Icons.logout,
              label: 'Logout',
              onTap: () async {
                Navigator.pop(context); 

                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                  (route) => false,
                );
              },
              color: Colors.red,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget drawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontSize: 16)),
      onTap: onTap,
    );
  }
}
