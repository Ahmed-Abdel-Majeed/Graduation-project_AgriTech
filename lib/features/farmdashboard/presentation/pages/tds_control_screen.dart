import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:agri/features/farmdashboard/domain/models/tds_control.dart';

class TDSScreen extends StatefulWidget {
  const TDSScreen({super.key});

  @override
  State<TDSScreen> createState() => _TDSScreenState();
}

class _TDSScreenState extends State<TDSScreen> {
  TDSControl? tdsControl;
  bool isLoading = false;
  double? currentTDS;
  @override
  void initState() {
    super.initState();
    _loadControl();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final control = await FarmAPI.fetchTDSControl();
      final home = await FarmAPI.getDashboardHome();
      
      setState(() {
        tdsControl = control;
        currentTDS = home.lastReading.tds;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading TDS: $e')));
    }
  }

  Future<void> _loadControl() async {
    final result = await FarmAPI.fetchTDSControl();
    setState(() => tdsControl = result);
  }

  Future<void> _updateControl(TDSControl updated) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateTDSControl(updated);
      setState(() => tdsControl = updated);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('TDS settings updated')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitDose(double amount) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updateTDSDose(amount);
      await _loadControl();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dose scheduled')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelDose() async {
    await FarmAPI.updateTDSDose(0);
    await _loadControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TDS Control')),
      body:
          tdsControl == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusRow(),
                    const SizedBox(height: 20),
                    const Text(
                      'Set TDS Range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInput(
                            'Min TDS',

                            tdsControl!.min,
                            (v) => _updateControl(tdsControl!.copyWith(min: v)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInput(
                            'Max TDS',

                            tdsControl!.max,
                            (v) => _updateControl(tdsControl!.copyWith(max: v)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isLoading || tdsControl!.isControlledByAI
                                ? null
                                : () => _updateControl(tdsControl!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('SAVE TDS RANGE'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Manual Dosing',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    _buildDoseField('Dose Amount (mL)', tdsControl!.doseAmount),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                isLoading || tdsControl!.isControlledByAI
                                    ? null
                                    : () => _submitDose(tdsControl!.doseAmount),
                            child: const Text('SCHEDULE DOSE'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: isLoading ? null : _cancelDose,
                            child: const Text('CANCEL DOSE'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Note: Dosing commands are sent to hardware after a 10-minute delay, allowing cancellation.',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          label: Text(
            'Current TDS: ${tdsControl!.currentValue?.toStringAsFixed(2)}',
          ),
        ),
        Row(
          children: [
            const Text("Manual"),
            Switch(
              value: tdsControl!.isControlledByAI,
              onChanged:
                  (val) => _updateControl(
                    tdsControl!.copyWith(isControlledByAI: val),
                  ),
            ),
            const Text("AI"),
          ],
        ),
      ],
    );
  }

  Widget _buildInput(String label, double value, Function(double) onChanged) {
    final controller = TextEditingController(text: value.toStringAsFixed(1));
    return TextField(
      enabled: !tdsControl!.isControlledByAI && !isLoading,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onSubmitted: (val) => onChanged(double.tryParse(val) ?? value),
    );
  }

  Widget _buildDoseField(String label, double value) {
    final controller = TextEditingController(text: value.toStringAsFixed(1));
    return TextField(
      enabled: !tdsControl!.isControlledByAI && !isLoading,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (val) {
        final parsed = double.tryParse(val) ?? value;
        setState(() => tdsControl = tdsControl!.copyWith(doseAmount: parsed));
      },
    );
  }
}
