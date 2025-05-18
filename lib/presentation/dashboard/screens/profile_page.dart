import 'dart:convert';
import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../ui/widgets/app_navigator.dart';
import '../../../features/auth/presentation/pages/login_screen.dart';
import '../../shared/widgets/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  String _errorMessage = "";
  Map<String, dynamic> userData = {};
  final bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      setState(() {
        _errorMessage = "Err-NoToken";
      });
      AppNavigator.pushReplacement(context, const LoginScreen());
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("https://api-testapp.netlify.app/api/auth/profile"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          userData = data;
          _isLoading = false;
          _errorMessage = "";
        });
      } else {
        setState(() {
          _errorMessage = "فشل في جلب البيانات. الكود: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "خطأ أثناء الاتصال بالسيرفر: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    AppNavigator.pushReplacement(context, const LoginScreen());
  }

  void _showUpdatePasswordDialog() {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("تحديث كلمة المرور"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "الكلمة الحالية"),
              ),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "الكلمة الجديدة"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("إلغاء"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthCubit>().changePassword(
                  currentPasswordController.text,
                  newPasswordController.text,
                );
              },
              child: const Text("تحديث"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard({required String title, required String value}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          "$title:",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildPasswordCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: const Text(
          "Update Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: _showUpdatePasswordDialog,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOutSuccess) {
          AppNavigator.pushReplacement(context, const LoginScreen());
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          imagePath: "assets/images/logo.png",
          onBackPress: () {
            context.read<AuthCubit>().signOut();
          },
          onBackPressleading: () {
            Navigator.pushNamed(context, AppRoutes.home);
          },
        ),
        body:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        // backgroundImage: _buildProfileImage(),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard(
                        title: "Username",
                        value: userData['username'] ?? 'Not available',
                      ),
                      const SizedBox(height: 20),
                      _buildInfoCard(
                        title: "Email",
                        value: userData['email'] ?? 'Not available',
                      ),
                      const SizedBox(height: 20),
                      _buildPasswordCard(),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text(
                            "Delete Account",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          onPressed: _deleteAccount,
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
