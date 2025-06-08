import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_state.dart';
import 'package:screenwise/screenwise.dart';

import '../../../main/presentation/shared/widgets/custom_button.dart';
import 'login_header.dart';
import 'social_login_buttons.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double padding = width > 600 ? width * 0.4 : width * 0.05;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.home,
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('خطأ: ${state.message}')));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LoginHeader(),
                const SizedBox(height: 30),
                // TextField for Email
                ResponsiveContainer(
                  mobileWidthFraction: 1.0,
                  tabletWidthFraction: 0.55,
                  desktopWidthFraction: 0.36,

                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // TextField for Password
                ResponsiveContainer(
                  mobileWidthFraction: 1.0,
                  tabletWidthFraction: 0.55,
                  desktopWidthFraction: 0.36,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                ResponsiveContainer(
                  mobileWidthFraction: 1.0,
                  tabletWidthFraction: 0.55,
                  desktopWidthFraction: 0.36,
                  child: TextButton(
                    onPressed: () {},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                state is AuthLoading
                    ? const CircularProgressIndicator()
                    : ResponsiveContainer(
                      mobileWidthFraction: 1.0,
                      tabletWidthFraction: 0.55,
                      desktopWidthFraction: 0.36,
                      child: CustomElevatedButton(
                        text: 'Login',
                        onPressed: () {
                          context.read<AuthCubit>().signIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                      ),
                    ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.black26),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 1, color: Colors.black26),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SocialLoginButtons(),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have an Account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap:
                          () =>
                              Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text(
                        " Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
