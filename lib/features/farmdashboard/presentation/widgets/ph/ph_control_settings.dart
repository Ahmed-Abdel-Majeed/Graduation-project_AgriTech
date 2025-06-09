import 'package:agri/features/farmdashboard/domain/models/ph_control_type.dart';
import 'package:flutter/material.dart';

class PHControlSettings extends StatefulWidget {
  final PHControlType controlHandler;
  final void Function(PHControlType) setControlHandler;
  final bool isLoading;

  const PHControlSettings({
    super.key,
    required this.controlHandler,
    required this.setControlHandler,
    this.isLoading = false,
  });

  @override
  _PHControlSettingsState createState() => _PHControlSettingsState();
}

class _PHControlSettingsState extends State<PHControlSettings> {
  late TextEditingController minController;
  late TextEditingController maxController;

  @override
  void initState() {
    super.initState();
    minController = TextEditingController(
      text: widget.controlHandler.min.toStringAsFixed(1),
    );
    maxController = TextEditingController(
      text: widget.controlHandler.max.toStringAsFixed(1),
    );
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  void handleChange({required String field, required dynamic value}) {
    PHControlType updated;
    switch (field) {
      case 'isControlledByAI':
        updated = widget.controlHandler.copyWith(isControlledByAI: value);
        break;
      case 'min':
        updated = widget.controlHandler.copyWith(min: value);
        minController.text = value.toStringAsFixed(1);
        break;
      case 'max':
        updated = widget.controlHandler.copyWith(max: value);
        maxController.text = value.toStringAsFixed(1);
        break;
      default:
        updated = widget.controlHandler;
    }
    widget.setControlHandler(updated);
  }

  @override
  Widget build(BuildContext context) {
    final control = widget.controlHandler;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              label: Text(
                'Current pH: ${control.currentValue.toStringAsFixed(2)}',
              ),
            ),
            Row(
              children: [
                const Text(
                  "Manual",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: control.isControlledByAI,
                  onChanged: widget.isLoading
                      ? null
                      : (val) => handleChange(field: 'isControlledByAI', value: val),
                ),
                const SizedBox(width: 8),
                const Text(
                  "AI",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Set pH Range', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minController,
                enabled: !control.isControlledByAI && !widget.isLoading,
                decoration: const InputDecoration(
                  labelText: 'Min pH',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  isDense: true,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  final v = double.tryParse(val) ?? control.min;
                  handleChange(field: 'min', value: v);
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: maxController,
                enabled: !control.isControlledByAI && !widget.isLoading,
                decoration: const InputDecoration(
                  labelText: 'Max pH',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  isDense: true,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  final v = double.tryParse(val) ?? control.max;
                  handleChange(field: 'max', value: v);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed:
              (control.isControlledByAI || widget.isLoading) ? null : () {/* save logic if needed */},
          child: const Text('Save pH Range'),
        ),
      ],
    );
  }
}
