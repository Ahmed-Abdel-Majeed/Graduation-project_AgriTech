import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:agri/features/farmdashboard/domain/models/ph_control.dart';
import 'package:agri/features/farmdashboard/domain/models/dose_types.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class PHScreen extends StatefulWidget {
  const PHScreen({super.key});

  @override
  State<PHScreen> createState() => _PHScreenState();
}

class _PHScreenState extends State<PHScreen> {
  bool isLoading = false;
  PHControl? control;

  final TextEditingController minPHController = TextEditingController();
  final TextEditingController maxPHController = TextEditingController();
  final TextEditingController upDoseController = TextEditingController();
  final TextEditingController downDoseController = TextEditingController();

  Future<void> _loadControl() async {
    try {
      final result = await FarmAPI.fetchPHControl();
      control = result;

      minPHController.text = result.min.toStringAsFixed(1);
      maxPHController.text = result.max.toStringAsFixed(1);
      upDoseController.clear();
      downDoseController.clear();

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load pH data: $e")));
    }
  }

  Future<void> _updateControlRange() async {
    final min = double.tryParse(minPHController.text) ?? control!.min;
    final max = double.tryParse(maxPHController.text) ?? control!.max;

    setState(() => isLoading = true);
    try {
      final updated = control!.copyWith(min: min, max: max);
      await FarmAPI.updatePHControl(updated);
      control = updated;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("pH settings updated")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error updating: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitDose(DoseType type) async {
    final value =
        type == DoseType.up
            ? double.tryParse(upDoseController.text)
            : double.tryParse(downDoseController.text);

    if (value == null || value <= 0) return;

    setState(() => isLoading = true);
    try {
      await FarmAPI.schedulePhDose(type, value);
      await _loadControl();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Scheduled pH ${type == DoseType.up ? "UP" : "DOWN"} dose ($value mL)',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _toggleAIMode(bool val) async {
    setState(() => isLoading = true);
    try {
      final updated = control!.copyWith(isControlledByAI: val);
      await FarmAPI.updatePHControl(updated);
      control = updated;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error switching mode: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadControl();
  }

  @override
  void dispose() {
    minPHController.dispose();
    maxPHController.dispose();
    upDoseController.dispose();
    downDoseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: CustomAppBar(
        color: Colors.black,
        imagePath: "assets/images/aichat.png",
        onBackPress: () => Navigator.pop(context),
        title: "pH Control",

        
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAIModeSwitch(),
                     SizedBox(height: 20.h),
                    const Text(
                      'Set pH Range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                     SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField("Min pH", minPHController),
                        ),
                         SizedBox(width: 16.w),
                        Expanded(
                          child: _buildInputField("Max pH", maxPHController),
                        ),
                      ],
                    ),
                     SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isLoading || control!.isControlledByAI
                                ? null
                                : _updateControlRange,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          'SAVE PH RANGE',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ),
                     SizedBox(height: 24
                    .h),
                    const Text(
                      'Manual Dosing',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                     SizedBox(height: 16
                    
                    .h
                    ),
                    _buildDoseRow(
                      'pH UP Amount (mL)',
                      upDoseController,
                      DoseType.up,
                    ),
                     SizedBox(height: 12.h),
                    _buildDoseRow(
                      'pH DOWN Amount (mL)',
                      downDoseController,
                      DoseType.down,
                    ),
                     SizedBox(height: 16.h),
                     Text(
                      'Note: Dosing commands are sent to hardware after a 10-minute delay, allowing cancellation.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildAIModeSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Manual", style: TextStyle(fontSize: 15.sp)),
        Switch(
          value: control!.isControlledByAI,
          onChanged: isLoading ? null : _toggleAIMode,
        ),
        Text("AI", style: TextStyle(fontSize: 15.sp)),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      enabled: !control!.isControlledByAI && !isLoading,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 12.sp),
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

  Widget _buildDoseRow(
    String label,
    TextEditingController controller,
    DoseType type,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: !control!.isControlledByAI && !isLoading,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 12.sp),
              labelText: label,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              isDense: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 160,
          child: ElevatedButton(
            onPressed:
                (!control!.isControlledByAI && !isLoading)
                    ? () => _submitDose(type)
                    : null,
            child: Text(
              'SCHEDULE PH ${type == DoseType.up ? 'UP' : 'DOWN'}',
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ),
      ],
    );
  }
}
