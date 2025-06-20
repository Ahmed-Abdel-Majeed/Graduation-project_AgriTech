import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageLightboxDialog extends StatelessWidget {
  final String imageUrl;

  const ImageLightboxDialog({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.all(12.w),
      child: Stack(
        children: [
          InteractiveViewer(
            child: Center(
              child: Image.network(imageUrl),
            ),
          ),
          Positioned(
            top: 10.h,
            right: 10.w,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
