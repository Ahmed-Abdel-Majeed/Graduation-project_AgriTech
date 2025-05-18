import 'package:flutter/material.dart';
import '../../domain/models/control_types.dart';

class PHControlCard extends StatefulWidget {
  final PHControlType controlHandler;
  final void Function(PHControlType) setControlHandler;
  final bool isLoading;
  final int doseCountdown; // seconds remaining
  final void Function(DoseType type, double amount) setDoseHandler;
  final VoidCallback cancelDoseHandler;
  final PendingDoseOrder? pendingDoseOrder;
  final bool disabled;

  const PHControlCard({
    super.key,
    required this.controlHandler,
    required this.setControlHandler,
    this.isLoading = false,
    this.doseCountdown = 0,
    required this.setDoseHandler,
    required this.cancelDoseHandler,
    this.pendingDoseOrder,
    this.disabled = false,
  });

  @override
  _PHControlCardState createState() => _PHControlCardState();
}

class _PHControlCardState extends State<PHControlCard> {
  double doseUpAmount = 0;
  double doseDownAmount = 0;

  String formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void handleChange({required String field, required dynamic value}) {
    PHControlType updated;
    switch (field) {
      case 'isControlledByAI':
        updated = widget.controlHandler.copyWith(isControlledByAI: value);
        break;
      case 'min':
        updated = widget.controlHandler.copyWith(min: value);
        break;
      case 'max':
        updated = widget.controlHandler.copyWith(max: value);
        break;
      default:
        updated = widget.controlHandler;
    }
    widget.setControlHandler(updated);
  }

  @override
  void didUpdateWidget(covariant PHControlCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pendingDoseOrder == null) {
      setState(() {
        doseUpAmount = 0;
        doseDownAmount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final control = widget.controlHandler;
    final pendingOrder = widget.pendingDoseOrder;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with title and AI switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.science, size: 24),
                    SizedBox(width: 8),
                    Text(
                      'pH Control',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: control.isControlledByAI,
                  onChanged: widget.isLoading
                      ? null
                      : (val) =>
                          handleChange(field: 'isControlledByAI', value: val),
                ),
              ],
            ),
            const Divider(height: 20),

            // Current pH Chip
            Chip(
              label: Text(
                'Current pH: ${control.currentValue.toStringAsFixed(2)}',
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              'Set pH Range',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: !control.isControlledByAI && !widget.isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Min pH',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (val) {
                      final v = double.tryParse(val) ?? control.min;
                      handleChange(field: 'min', value: v);
                    },
                    controller: TextEditingController(
                      text: control.min.toStringAsFixed(1),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    enabled: !control.isControlledByAI && !widget.isLoading,
                    decoration: const InputDecoration(
                      labelText: 'Max pH',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (val) {
                      final v = double.tryParse(val) ?? control.max;
                      handleChange(field: 'max', value: v);
                    },
                    controller: TextEditingController(
                      text: control.max.toStringAsFixed(1),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (control.isControlledByAI || widget.isLoading)
                  ? null
                  : () {
                      // Save pH range button pressed
                      // Implement your save logic here
                    },
              child: const Text('Save pH Range'),
            ),

            const Divider(height: 32),

            const Text(
              'Manual Dosing',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            if (pendingOrder != null)
              Container(
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange.shade700,
                    style: BorderStyle.solid,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pending Order: ${pendingOrder.amount} mL pH ${pendingOrder.type == DoseType.up ? "UP" : "DOWN"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Hardware execution scheduled in approx. 10 mins. Cancel within:',
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          formatTime(widget.doseCountdown),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: widget.isLoading
                              ? null
                              : widget.cancelDoseHandler,
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
