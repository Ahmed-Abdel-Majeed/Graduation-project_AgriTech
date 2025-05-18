// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final VoidCallback onBackPress;
    final VoidCallback onBackPressleading;


  const CustomAppBar({
    super.key,
    required this.imagePath,
  required   this.onBackPress, required this.onBackPressleading,
  });

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
      actions: [
        IconButton(onPressed:onBackPress , icon: Icon(Icons.logout,color: Colors.red))
      ],
        leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color:             Color(0xFF064F3C),

            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 19,
            ),
            onPressed: onBackPressleading,
          ),
        ),
      ),
  
        title: Image.asset(
          imagePath,
          height: 80, 
        ),
        centerTitle: true, 
      ),
    );
  
  }

  @override
  Size get preferredSize => const Size.fromHeight(60); 
}
