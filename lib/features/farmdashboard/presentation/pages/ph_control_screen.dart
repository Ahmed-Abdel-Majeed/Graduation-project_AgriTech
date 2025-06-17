import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/data/services/farm_api_service.dart';
import 'package:agri/features/farmdashboard/domain/models/ph_control.dart';
import 'package:agri/features/farmdashboard/domain/models/dose_types.dart';

class PHScreen extends StatefulWidget {
  const PHScreen({super.key});

  @override
  State<PHScreen> createState() => _PHScreenState();
}

class _PHScreenState extends State<PHScreen> {
  bool isLoading = false;
  PHControl? control;
  double upDose = 0;
  double downDose = 0;

  Future<void> _loadControl() async {
    try {
      final result = await FarmAPI.fetchPHControl();
      setState(() => control = result);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load pH data: $e")));
    }
  }

  Future<void> _updateControl(PHControl updated) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.updatePHControl(updated);
      setState(() => control = updated);
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

  Future<void> _submitDose(DoseType type, double amount) async {
    setState(() => isLoading = true);
    try {
      await FarmAPI.schedulePhDose(type, amount);
      await _loadControl();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Scheduled pH ${type == DoseType.up ? "UP" : "DOWN"} dose ($amount mL)',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelDose() async {
    await FarmAPI.cancelPhDose();
    await _loadControl();
  }

  @override
  void initState() {
    super.initState();
    _loadControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('pH Control')),
      body:
          control == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusRow(),
                    const SizedBox(height: 20),
                    const Text(
                      'Set pH Range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInput(
                            'Min pH',
                            control!.min,
                            (v) => _updateControl(control!.copyWith(min: v)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInput(
                            'Max pH',
                            control!.max,
                            (v) => _updateControl(control!.copyWith(max: v)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isLoading || control!.isControlledByAI
                                ? null
                                : () => _updateControl(control!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text('SAVE PH RANGE'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Manual Dosing',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    _buildDoseRow('pH UP Amount (mL)', upDose, true),
                    const SizedBox(height: 12),
                    _buildDoseRow('pH Down Amount (mL)', downDose, false),
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
            'Current pH: ${control!.currentValue.toStringAsFixed(2)}',
          ),
        ),
        Row(
          children: [
            const Text("Manual"),
            Switch(
              value: control!.isControlledByAI,
              onChanged:
                  (val) =>
                      _updateControl(control!.copyWith(isControlledByAI: val)),
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
      enabled: !control!.isControlledByAI && !isLoading,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onSubmitted: (val) => onChanged(double.tryParse(val) ?? value),
    );
  }

  Widget _buildDoseRow(String label, double value, bool isUp) {
    final controller = TextEditingController(text: value.toStringAsFixed(1));
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: !control!.isControlledByAI && !isLoading,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              isDense: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (val) {
              final parsed = double.tryParse(val) ?? 0;
              setState(() {
                if (isUp) {
                  upDose = parsed;
                } else {
                  downDose = parsed;
                }
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 160,
          child: ElevatedButton(
            onPressed:
                (!control!.isControlledByAI && value > 0 && !isLoading)
                    ? () =>
                        _submitDose(isUp ? DoseType.up : DoseType.down, value)
                    : null,
            child: Text('SCHEDULE PH ${isUp ? 'UP' : 'DOWN'}'),
          ),
        ),
      ],
    );
  }
}
