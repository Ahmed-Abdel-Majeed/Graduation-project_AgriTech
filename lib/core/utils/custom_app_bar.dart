// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final String title;
  final VoidCallback onBackPress;
  final VoidCallback? onBackPressleading;
  final Color? color;

  const CustomAppBar({
    super.key,
    required this.imagePath,
    required this.onBackPress,
    this.onBackPressleading,
    required this.title, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(.45),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        iconTheme: IconThemeData(color: color),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: onBackPress,
              child: Image.asset("assets/images/aichat.png"),
            ),
          ),
        ],

        //   leading: Padding(
        //   padding: const EdgeInsets.all(12.0),
        //   child: Container(
        //     width: 28,
        //     height: 28,
        //     decoration: const BoxDecoration(
        //       color:             Color(0xFF064F3C),

        //       shape: BoxShape.circle,
        //     ),
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.white,
        //         size: 19,
        //       ),
        //       onPressed: onBackPressleading,
        //     ),
        //   ),
        // ),
        title: Text(title,style: TextStyle(fontSize: 15.sp,color: Colors.black,),
                ),       centerTitle: true,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
