import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Image(image: AssetImage('assets/images/8400 2.png'), height: 150),
        SizedBox(height: 20),
        Text('Welcome Back!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Login to your account', style: TextStyle(fontSize: 16, color: Colors.black54)),
      ],
    );
  }
}
