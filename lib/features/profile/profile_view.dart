import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';

class ProfileView extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileView({super.key, required this.userData});

  void _showUpdatePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Update Password"),
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Current Password"),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "New Password"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthCubit>().changePassword(
                    currentPasswordController.text,
                    newPasswordController.text,
                  );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(radius: 60),
          const SizedBox(height: 20),
          _infoCard("Username", userData['username'] ?? "N/A"),
          const SizedBox(height: 20),
          _infoCard("Email", userData['email'] ?? "N/A"),
          const SizedBox(height: 20),
          _passwordCard(context),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => context.read<AuthCubit>().signOut(),
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text("Delete Account"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        title: Text(
          "$title:",
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(value),
      ),
    );
  }

  Widget _passwordCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        title: const Text("Update Password"),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () => _showUpdatePasswordDialog(context),
        ),
      ),
    );
  }
}
