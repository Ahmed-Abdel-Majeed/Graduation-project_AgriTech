import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agri/features/plant_analysis/widgets/image_lightbox_dialog.dart';

class PlantImageSection extends StatelessWidget {
  final String? imageUrl;

  const PlantImageSection({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Plant Visuals (Click to Enlarge)", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (_) => ImageLightboxDialog(imageUrl: imageUrl!),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              imageUrl!,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
