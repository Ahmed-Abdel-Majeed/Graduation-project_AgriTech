import 'package:flutter/material.dart';

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPress;

  const LoginAppBar({super.key, required this.onBackPress});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: Color(0xFF267EAA),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 19,
            ),
            onPressed: onBackPress,
          ),
        ),
      ),
  
  
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
