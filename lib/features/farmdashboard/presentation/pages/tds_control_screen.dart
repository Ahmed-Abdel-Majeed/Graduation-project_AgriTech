import 'package:agri/core/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:agri/features/farmdashboard/domain/models/tds_control.dart';
import 'package:lottie/lottie.dart';

class TDSScreen extends StatefulWidget {
  const TDSScreen({super.key});

  @override
  State<TDSScreen> createState() => _TDSScreenState();
}

class _TDSScreenState extends State<TDSScreen> {
  TDSControl? tdsControl;
  bool isLoading = false;
  final doseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadControl();
  }

  Future<void> _loadControl() async {
    final result = await FarmAPI.fetchTDSControl();
    setState(() {
      tdsControl = result;
      doseController.text = result.doseAmount.toString();
    });
  }

  Future<void> _updateControl(TDSControl updated) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateTDSControl(updated);
      setState(() => tdsControl = updated);
      _showMessage('TDS settings updated');
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitDose() async {
    final amount = double.tryParse(doseController.text) ?? 0;
    if (amount <= 0) return;

    setState(() => isLoading = true);
    try {
      await FarmAPI.updateTDSDose(amount);
      await _loadControl();
      _showMessage('Dose scheduled');
    } catch (e) {
      _showMessage('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelDose() async {
    await FarmAPI.updateTDSDose(0);
    await _loadControl();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    doseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        color: Colors.black,
        imagePath: "assets/images/aichat.png",
        onBackPress: () => Navigator.pop(context),
        title: "TDS Control",

        
      ),      body: tdsControl == null
          ? Center(
                child: Lottie.asset(
                  'assets/Animation - 1750348692344.json',
                  width: 250.w,
                  height: 250.h,
                ),
              )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Manual"),
                        Switch(
                          value: tdsControl!.isControlledByAI,
                          onChanged: (val) => _updateControl(
                            tdsControl!.copyWith(isControlledByAI: val),
                          ),
                        ),
                        const Text("AI"),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text('Set TDS Range',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildNumberInput(
                            'Min TDS',
                            tdsControl!.min,
                            (v) => _updateControl(tdsControl!.copyWith(min: v)),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildNumberInput(
                            'Max TDS',
                            tdsControl!.max,
                            (v) => _updateControl(tdsControl!.copyWith(max: v)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('SAVE TDS RANGE'),
                        onPressed: isLoading || tdsControl!.isControlledByAI
                            ? null
                            : () => _updateControl(tdsControl!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text('Manual Dosing',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 12.h),
                    _buildDoseInput(),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading || tdsControl!.isControlledByAI
                                ? null
                                : _submitDose,
                            child: const Text('SCHEDULE DOSE'),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _cancelDose,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('CANCEL DOSE'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Note: Dosing commands are sent to hardware after a 10-minute delay.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildNumberInput(String label, double value, Function(double) onChanged) {
    final controller = TextEditingController(text: value.toString());
    return TextField(
      enabled: !tdsControl!.isControlledByAI && !isLoading,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onSubmitted: (val) => onChanged(double.tryParse(val) ?? value),
    );
  }

  Widget _buildDoseInput() {
    return TextField(
      controller: doseController,
      enabled: !tdsControl!.isControlledByAI && !isLoading,
      decoration: InputDecoration(
        labelText: 'Dose Amount (mL)',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        prefixIcon: const Icon(Icons.local_drink),
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
