import 'package:agri/config/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.green,
      child: Column(
        children: [
          const SizedBox(height: 50),

          Column(
            children: [
              CircleAvatar(
                radius: 40,
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
              Navigator.pushNamed(context, AppRoutes.profilePage);
            },
          ),
          drawerItem(icon: Icons.settings, label: 'Setting', onTap: () {}),
          drawerItem(icon: Icons.info_outline, label: 'About', onTap: () {}),

          const Spacer(),

          drawerItem(
            icon: Icons.logout,
            label: 'Logout',
            onTap: () {},
            color: Colors.red,
          ),

          const SizedBox(height: 20),
        ],
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
