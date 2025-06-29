import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/farmdashboard/domain/models/water_pump_control_type.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class WaterPumpControlScreen extends StatefulWidget {
  const WaterPumpControlScreen({super.key});

  @override
  State<WaterPumpControlScreen> createState() => _WaterPumpControlScreenState();
}

class _WaterPumpControlScreenState extends State<WaterPumpControlScreen> {
  bool isLoading = false;
  WaterPumpControl? control;
  late TextEditingController durationController;

  Future<void> _loadControl() async {
    try {
      final result = await FarmAPI.fetchWaterPumpControl();
      durationController = TextEditingController(
        text: result.durationMinutes.toString(),
      );
      setState(() => control = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load water pump data: $e")),
      );
    }
  }

  Future<void> _updateControl(WaterPumpControl updated) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateWaterPumpControl(updated);
      setState(() => control = updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Water pump settings updated")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error updating: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    durationController = TextEditingController();
    _loadControl();
  }

  @override
  void dispose() {
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: CustomAppBar(
        color: Colors.black,
        imagePath: "assets/images/aichat.png",
        onBackPress: () => Navigator.pop(context),
        title: "Water Pump Control",

        
      ),       body:
          control == null
              ? Center(
                child: Lottie.asset(
                  'assets/Animation - 1750348692344.json',
                  width: 250.w,
                  height: 250.h,
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Chip(
                          avatar:  Icon(
                            Icons.warning_amber_rounded,
                            size: 18.sp,
                          ),
                          label: Text(
                            control!.isCurrentlyRunning
                                ? "Pump ON"
                                : "Pump OFF",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  control!.isCurrentlyRunning
                                      ? Colors.green
                                      : Colors.black87,
                            ),
                          ),
                          backgroundColor:
                              control!.isCurrentlyRunning
                                  ? Colors.green.shade100
                                  : Colors.grey.shade200,
                        ),
                        SizedBox(width: 12.w,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Manual",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: control!.isControlledByAI,
                              onChanged:
                                  isLoading
                                      ? null
                                      : (val) {
                                        final updated = control!.copyWith(
                                          isControlledByAI: val,
                                        );
                                        _updateControl(updated);
                                      },
                            ),
                            const Text(
                              "AI",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                     SizedBox(height: 24.h),
                    const Text(
                      "Run Duration per Hour (minutes)",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                     SizedBox(height: 8.h),
                    TextField(
                      enabled: !control!.isControlledByAI && !isLoading,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                      ),
                      controller: durationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                     SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isLoading || control!.isControlledByAI
                                ? null
                                : () {
                                  final v = int.tryParse(
                                    durationController.text,
                                  );
                                  if (v != null) {
                                    _updateControl(
                                      control!.copyWith(durationMinutes: v),
                                    );
                                  }
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('SAVE PUMP DURATION'),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
