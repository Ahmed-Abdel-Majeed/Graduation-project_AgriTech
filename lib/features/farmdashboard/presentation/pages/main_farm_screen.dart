import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/farmdashboard/presentation/pages/history_log_screen.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/hardware_status.dart';
import 'package:flutter/material.dart';
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
          SizedBox(height: 10.h,),
          Row(
            children: [
              const SizedBox(width: 8),
              Expanded(child: const HardwareStatus()),
            ],
          ),
          Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
          const SizedBox(height: 10),
          GridView.count(
            physics:
                const NeverScrollableScrollPhysics(),
            shrinkWrap: true, 
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
            childAspectRatio: 2*(width/height),
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
                            height: 140,
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
      Divider(thickness: .5,),
        SizedBox(
          height: 150.h,
          child: HistoryScreen())
        ],
      ),
    );
  }
}
