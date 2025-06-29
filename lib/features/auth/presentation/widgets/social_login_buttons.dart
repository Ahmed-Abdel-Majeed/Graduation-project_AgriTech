import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agri/features/auth/presentation/cuibt/auth_cubit.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
          child: Card(
            elevation: 5,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Image.asset("assets/google.png"),
              ),
            ),
          ),
        ),
        // const SizedBox(width: 22),
        // InkWell(
        //   onTap: () {
        //     // Facebook login
        //   },
        //   child: Card(
        //     elevation: 5,
        //     child: Container(
        //       width: 60,
        //       height: 60,
        //       decoration: BoxDecoration(
        //         color: const Color.fromARGB(255, 60, 87, 186),
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(11.0),
        //         child: Image.asset(
        //           "assets/facebook.png",
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
    
      ],
    );
  }
}
