import 'package:agri/features/home/presentation/screens/air_water_temperature_dashboard.dart';
import 'package:agri/features/home/presentation/screens/ph_ec_page.dart';
import 'package:agri/features/home/presentation/widgets/top_metrics_row.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/sensor_reading.dart';

class SensorsDashboard extends StatefulWidget {
  const SensorsDashboard({super.key, });

  @override
  State<SensorsDashboard> createState() => _SensorsDashboardState();
}

class _SensorsDashboardState extends State<SensorsDashboard>
    with TickerProviderStateMixin {
  final List<String> timeRanges = [
    'Last 12 Hours',
    'Last 24 Hours',
    'Last 7 Days',
  ];
  final List<String> periods = ['12h', '24h', '7d'];

  String selectedRange = 'Last 12 Hours';

  final List<SensorReading> readings = [
    SensorReading(
      time: DateTime.now(),
      ph: 5.4,
      airtemp: 23.2,
      ec: 2.8,
      waterLevel: 52.8,
      watertemp: 55,
      humidity: 52.8,
    ),
  ];

  bool _showDetails = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: timeRanges.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final isSmallScreen = media.width < 600;

    return  Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            TopMetricsRow(readings: readings),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8.0 : 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Review',
                    style: TextStyle(
                      fontSize: media.width * (isSmallScreen ? 0.05 : 0.053),
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    },
                    child: Text(
                      "showing AI-generated insights",
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  if (_showDetails) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Description: This section shows AI-generated insights.',
                      style: TextStyle(fontSize: media.width * 0.04),
                    ),
                    Text(
                      'Status: Completed',
                      style: TextStyle(
                        fontSize: media.width * 0.04,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Time Range Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TabBar(
                dividerColor: Colors.transparent  ,
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xff22D828),
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,

                indicator: BoxDecoration(
                  
                  border: Border.all(color: const Color(0xff22D828), width: 2),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                tabs: timeRanges.map((range) => Tab(text: range)).toList(),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    periods.map((period) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              // رسم درجة الحرارة والرياح
                              AirWaterTemperatureDashboard(period: period),
                              const SizedBox(height: 20),
                              // رسم pH و EC و الرطوبة
                              SizedBox(
                                height: 400,
                                width: media.width,
                                child: PhEcPage(period: period),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      
    );
  }
}
