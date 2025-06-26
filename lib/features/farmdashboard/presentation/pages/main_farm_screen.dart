import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/farmdashboard/presentation/pages/history_log_screen.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/hardware_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainFarmScreen extends StatefulWidget {
  const MainFarmScreen({super.key});

  @override
  State<MainFarmScreen> createState() => _MainFarmScreenState();
}

class _MainFarmScreenState extends State<MainFarmScreen> {
  List farmMange = [
    {
      "name": "Light Control",
      "photo": "assets/images/lightcontrol.jpeg",
      "index": 3,
    },
    {
      "name": "TDS(EC) Control",
      "photo": "assets/images/TDS(EC) Control.jpeg",
      "index": 2,
    },
    {
      "name": "Water Pump Control",
      "photo": "assets/images/Water Pump Control.jpeg",
      "index": 0,
    },
    {
      "name": "PH Control",
      "photo": "assets/images/PH Control.jpeg",
      "index": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(
        imagePath: "assets/images/aichat.png",
        onBackPress: () {},
        title: "Farm Dashboard",
        color: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Row(
            children: [
              const SizedBox(width: 8),
              Expanded(child: const HardwareStatus()),
            ],
          ),
          Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
          const SizedBox(height: 10),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 2 * (width / height),
            children:
                farmMange.map((e) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.farmdashboard,
                        arguments: e['index'],
                      );
                    },
                    child: Card(
                      color: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 11,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 130.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              image: DecorationImage(
                                image: AssetImage(
                                  e['photo'] ??
                                      'assets/images/default_image.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            e['name'] ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),

          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => Dialog(
                      backgroundColor: Colors.white,
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 40.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: HistoryScreen()
                                  .animate() // apply animation
                                  .fadeIn(duration: 500.ms)
                                  .scale(
                                    begin: const Offset(0.95, 0.95),
                                    duration: 500.ms,
                                  ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/history.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "History Log",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20.sp,
                    ), // ✅ Add Check Icon
                  ],
                ),
              ],
            ).animate().fadeIn(duration: 600.ms), // animate the card itself
          ),
        ],
      ),
    );
  }
}
