import 'package:agri/config/routes/app_routes.dart';
import 'package:agri/features/farmdashboard/data/repositories/hydroponics_repository_impl.dart';
import 'package:agri/features/farmdashboard/presentation/controllers/history_controller.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/hardware_status.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/history_log_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(0, 0, 0, 0)),
        title: const Text(
          "Farm Dashboard",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 8),
                Expanded(child: const HardwareStatus()),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: 1, height: 1),
            const SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: GridView(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: .82,
                ),
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
                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  height: 200,
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
            ),
          
          
          
    _buildHistorySection(),
          
          ],
        ),
      ),
    );
  }
}

Widget _buildHistorySection() {
  return ChangeNotifierProvider(
    create: (_) => HistoryController(FarmRepositoryImpl()),
    child: Consumer<HistoryController>(
      builder: (context, controller, _) {
        return HistoryLogCard(historyLog: controller.historyLog);
      },
    ),
  );
}
