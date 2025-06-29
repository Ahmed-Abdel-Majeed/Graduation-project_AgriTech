import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:agri/features/farmdashboard/domain/models/light_model.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LightSystemControlScreen extends StatefulWidget {
  const LightSystemControlScreen({super.key});

  @override
  State<LightSystemControlScreen> createState() =>
      _LightSystemControlScreenState();
}

class _LightSystemControlScreenState extends State<LightSystemControlScreen> {
  LightControl? control;
  LightControl?
  initialAiLightControl;

  bool isLoading = false;

  Future<void> _pickTime(String type, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      final timeString = picked.format(context);
      setState(() {
        if (type == 'white') {
          control = control!.copyWith(
            whiteLight: control!.whiteLight.copyWith(
              startTime: isStart ? timeString : control!.whiteLight.startTime,
              stopTime: isStart ? control!.whiteLight.stopTime : timeString,
            ),
          );
        } else {
          control = control!.copyWith(
            growthLight: control!.growthLight.copyWith(
              startTime: isStart ? timeString : control!.growthLight.startTime,
              stopTime: isStart ? control!.growthLight.stopTime : timeString,
            ),
          );
        }
      });
    }
  }

  Future<void> _saveControl(LightControl updated) async {
    if (!mounted) return;
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateLightSystem(updated);
      if (!mounted) return;
      setState(() => control = updated);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Light schedule saved successfully")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadControl() async {
    final result = await FarmAPI.getFarmControl();
    if (!mounted) return;

    setState(() {
      control = result.lightSystem;

      if (control!.isControlledByAI) {
        initialAiLightControl = control!.copyWith(
          whiteLight: control!.whiteLight.copyWith(),
          growthLight: control!.growthLight.copyWith(),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: CustomAppBar(
        color: Colors.black,
        imagePath: "assets/images/aichat.png",
        onBackPress: () => Navigator.pop(context),
        title: "Lights Control",

        
      ),       body:
          control == null
              ? Center(
                child: Lottie.asset(
                  'assets/Animation - 1750348692344.json',
                  width: 250.w,
                  height: 250.h,
                ),
              )
              : SingleChildScrollView(
                padding:  EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Manual',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: control!.isControlledByAI,
                          onChanged: (val) async {
                            if (val) {
                              //  المستخدم فعّل AI
                              if (initialAiLightControl != null) {
                                await _saveControl(initialAiLightControl!);
                              } else {
                                // fallback لو النسخة مش محفوظة
                                await _saveControl(
                                  control!.copyWith(isControlledByAI: true),
                                );
                              }
                            } else {
                              //  المستخدم لغى AI
                              await _saveControl(
                                control!.copyWith(isControlledByAI: false),
                              );
                            }
                          },
                        ),

                        const Text(
                          'AI',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                     SizedBox(height: 16.h),
                    Row(
                      // spacing: ,
                      children: [
                        _buildStatusChip(
                          'White Light',
                          control!.whiteLight.isCurrentlyOn,
                        ),
                        _buildStatusChip(
                          'Growth Light',
                          control!.growthLight.isCurrentlyOn,
                        ),
                      ],
                    ),
                     SizedBox(height: 24.h),
                    _buildScheduleBlock(
                      title: 'White Light Schedule',
                      start: control!.whiteLight.startTime,
                      end: control!.whiteLight.stopTime,
                      onPickStart: () => _pickTime('white', true),
                      onPickEnd: () => _pickTime('white', false),
                    ),
                     SizedBox(height: 20.h),
                    _buildScheduleBlock(
                      title: 'Red/Blue (Growth) Light Schedule',
                      start: control!.growthLight.startTime,
                      end: control!.growthLight.stopTime,
                      onPickStart: () => _pickTime('growth', true),
                      onPickEnd: () => _pickTime('growth', false),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            control!.isControlledByAI || isLoading
                                ? null
                                : () => _saveControl(control!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('SAVE LIGHT SCHEDULE'),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildStatusChip(String label, bool isOn) {
    return SizedBox(
      width: 170.w,
      child: Chip(
        
        avatar:  Icon(Icons.warning_amber_rounded, size: 18.sp),
        label: Text(
          '$label ${isOn ? "ON" : "OFF"}',
          style: TextStyle(
            fontSize: label.length > 10 ? 12 : 14,
            fontWeight: FontWeight.w600,
            color: isOn ? Colors.green : Colors.black87,
          ),
        ),
        backgroundColor: isOn ? Colors.green.shade100 : Colors.grey.shade200,
      ),
    );
  }

  Widget _buildScheduleBlock({
    required String title,
    required String start,
    required String end,
    required VoidCallback onPickStart,
    required VoidCallback onPickEnd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
         SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: control!.isControlledByAI ? null : onPickStart,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Start Time',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: start),
                  ),
                ),
              ),
            ),
             SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: control!.isControlledByAI ? null : onPickEnd,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Stop Time',
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: end),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
