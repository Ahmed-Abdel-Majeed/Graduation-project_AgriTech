import 'package:agri/features/home/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/home/presentation/widgets/top_metrics_row.dart';
import 'package:agri/features/home/presentation/screens/air_water_temperature_dashboard.dart';
import 'package:agri/features/home/presentation/screens/ph_ec_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:translator/translator.dart';
import '../../data/domain/entities/sensor_reading.dart';
import 'sensor_data_dashboard.dart';

class SensorsDashboard extends StatefulWidget {
  const SensorsDashboard({super.key});

  @override
  State<SensorsDashboard> createState() => _SensorsDashboardState();
}

class _SensorsDashboardState extends State<SensorsDashboard>
    with TickerProviderStateMixin {
  int selectedIndex = 0;

  final ApiService _apiService = ApiService();
  final List<String> timeRanges = [
    'Last 12 Hours',
    'Last 24 Hours',
    'Last 7 Days',
  ];
  final List<String> periods = ['12h', '24h', '7d'];
  final List<int> secondsRange = [6000000000 * 12, 3600 * 24, 3600 * 24 * 7];

  late TabController _tabController;
  bool _loading = true;
  bool _showDetails = false;
  String aiSummary = '';
  String aiDetails = '';

  // متغيرات الترجمة
  bool _isTranslatedToArabic = false;
  String _translatedSummary = '';
  String _translatedDetails = '';
  final GoogleTranslator _translator = GoogleTranslator();
  bool _isTranslating = false;

  SensorReading? lastReading;
  List<SensorDataDashboard> airTempData = [];
  List<SensorDataDashboard> waterTempData = [];
  List<SensorDataDashboard> humidityData = [];
  List<SensorDataDashboard> phData = [];
  List<SensorDataDashboard> ecData = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: timeRanges.length, vsync: this);
    _loadData(0);
  }

  Future<void> _loadData(int index) async {
    if (!mounted) return;
    setState(() => _loading = true);

    try {
      final data = await _apiService.fetchDashboardData(secondsRange[index]);
      if (!mounted) return;

      final trends = data['trends'];
      final timestamps = List<int>.from(trends['timestamp']);

      airTempData = _mapTrends(timestamps, trends['airTemp']);
      waterTempData = _mapTrends(timestamps, trends['waterTemp']);
      humidityData = _mapTrends(timestamps, trends['humidity']);
      phData = _mapTrends(timestamps, trends['ph']);
      ecData = _mapTrends(
        timestamps,
        trends['tds'] ?? List.filled(timestamps.length, 0),
      );

      aiSummary = data['aiInsights']['summary'] ?? '';
      aiDetails = data['aiInsights']['details'] ?? '';

      // إعادة تعيين حالة الترجمة عند تحميل بيانات جديدة
      _isTranslatedToArabic = false;
      _translatedSummary = '';
      _translatedDetails = '';

      final r = data['lastReading'];
      lastReading = SensorReading(
        time: DateTime.fromMillisecondsSinceEpoch(r['timestamp'] * 1000),
        ph: r['ph']?.toDouble() ?? 0,
        airtemp: r['airTemp']?.toDouble() ?? 0,
        tds: r['tds']?.toDouble() ?? 0,
        waterLevel: r['waterLevel']?.toDouble() ?? 0,
        watertemp: r['waterTemp']?.toDouble() ?? 0,
        humidity: r['humidity']?.toDouble() ?? 0,
      );
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }

    if (!mounted) return;
    setState(() => _loading = false);
  }

  List<SensorDataDashboard> _mapTrends(
    List<int> timestamps,
    List<dynamic> values,
  ) {
    return List.generate(timestamps.length, (i) {
      return SensorDataDashboard(
        DateTime.fromMillisecondsSinceEpoch(timestamps[i] * 1000),
        (values[i] ?? 0).toDouble(),
      );
    });
  }

  Future<void> _toggleTranslation() async {
    if (_isTranslating) return;

    setState(() => _isTranslating = true);

    try {
      if (_isTranslatedToArabic) {
        // العودة إلى النص الأصلي بالإنجليزية
        setState(() {
          _translatedSummary = '';
          _translatedDetails = '';
          _isTranslatedToArabic = false;
        });
      } else {
        // الترجمة إلى العربية
        final summaryTranslation = await _translator.translate(
          aiSummary,
          from: 'en',
          to: 'ar',
        );
        final detailsTranslation = await _translator.translate(
          aiDetails,
          from: 'en',
          to: 'ar',
        );

        setState(() {
          _translatedSummary = summaryTranslation.text;
          _translatedDetails = detailsTranslation.text;
          _isTranslatedToArabic = true;
        });
      }
    } catch (e) {
      debugPrint('Translation error: $e');
      // استخدام النص الأصلي في حالة فشل الترجمة
      setState(() {
        _translatedSummary = aiSummary;
        _translatedDetails = aiDetails;
        _isTranslatedToArabic = true;
      });
    } finally {
      setState(() => _isTranslating = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _loading
              ? Center(
                child: Lottie.asset(
                  'assets/Animation - 1750348692344.json',
                  width: 250.w,
                  height: 250.h,
                ),
              )
              : SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    if (lastReading != null)
                      TopMetricsRow(readings: [lastReading!]),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 5.h,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'AI Review',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  IconButton(
                                    icon:
                                        _isTranslating
                                            ? CircularProgressIndicator()
                                            : Icon(
                                              _isTranslatedToArabic
                                                  ? Icons.translate
                                                  : Icons.translate_outlined,
                                              color:
                                                  _isTranslatedToArabic
                                                      ? Colors.blue
                                                      : Colors.grey,
                                            ),
                                    onPressed: _toggleTranslation,
                                    tooltip:
                                        _isTranslatedToArabic
                                            ? 'Show in English'
                                            : 'Translate to Arabic',
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap:
                                    () => setState(
                                      () => _showDetails = !_showDetails,
                                    ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 4.h),
                                  child: Text(
                                    "showing AI-generated insights",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              if (_showDetails)
                                SizedBox(
                                  height: 400.h,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.h),
                                        Text(
                                          '${_isTranslatedToArabic ? "الوصف" : "description"} : ${_isTranslatedToArabic ? _translatedSummary : aiSummary}',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.grey[700],
                                          ),
                                          textDirection:
                                              _isTranslatedToArabic
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          '${_isTranslatedToArabic ? "الحاله" : "Status"}: ${_isTranslatedToArabic ? _translatedDetails : aiDetails}',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.green,
                                          ),
                                          textDirection:
                                              _isTranslatedToArabic
                                                  ? TextDirection.rtl
                                                  : TextDirection.ltr,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(timeRanges.length, (index) {
                        final isSelected = index == selectedIndex;
                        return Padding(
                          padding: EdgeInsets.all(6.w),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                _loadData(index);
                              });
                            },
                            child: Container(
                              width: 110.w,
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : Colors.white,
                                border: Border.all(
                                  color:
                                      isSelected ? Colors.green : Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                timeRanges[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            children: [
                              AirWaterTemperatureDashboard.fromAPI(
                                airTemperatureData: airTempData,
                                waterTemperatureData: waterTempData,
                                humidityData: humidityData,
                                period: periods[selectedIndex],
                              ),
                              SizedBox(height: 20.h),
                              SizedBox(
                                height: 400.h,
                                width: double.infinity,
                                child: PhEcPage.fromAPI(
                                  phData: phData,
                                  ecData: ecData,
                                  period: periods[selectedIndex],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
