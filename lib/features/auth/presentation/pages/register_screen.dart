import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/core/utils/di/injection.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';
import '../../data/repositories/user_repository.dart';
import '../widgets/register_form.dart';
import '../widgets/register_header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(getIt<UserRepository>()),
      child: Scaffold(
          resizeToAvoidBottomInset: true, 

  
      body:    SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               RegisterHeader(),
              RegisterForm(),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
