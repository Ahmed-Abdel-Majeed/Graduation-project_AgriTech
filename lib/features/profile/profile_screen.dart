import 'package:agri/features/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_state.dart';
import 'package:agri/features/profile/data/profile_api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  String _errorMessage = "";
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final result = await ProfileApiService().getUserProfile();
    if (result['error'] != null) {
      setState(() {
        _errorMessage = result['error'];
        _isLoading = false;
      });
    } else {
      setState(() {
        userData = result['data'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOutSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          imagePath: "assets/images/aichat.png",
          onBackPress: () {},
          title: "Profile",
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage))
                : ProfileView(userData: userData),
      ),
    );
  }
}
