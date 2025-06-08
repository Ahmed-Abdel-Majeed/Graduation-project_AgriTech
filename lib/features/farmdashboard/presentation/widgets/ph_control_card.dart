import 'package:flutter/material.dart';
import '../../domain/models/ph_control_type.dart';
import '../../domain/models/dose_types.dart';
import 'render_ai_control_mode_switch.dart';

class PHControlCard extends StatefulWidget {
  final PHControlType controlHandler;
  final void Function(PHControlType) setControlHandler;
  final bool isLoading;
  final int doseCountdown;
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
  PHControlCardState createState() => PHControlCardState();
}

class PHControlCardState extends State<PHControlCard> {
  double doseUpAmount = 0;
  double doseDownAmount = 0;

  late TextEditingController doseUpController;
  late TextEditingController doseDownController;
  late TextEditingController minController;
  late TextEditingController maxController;

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
  void initState() {
    super.initState();
    doseUpController = TextEditingController(
      text: doseUpAmount.toStringAsFixed(1),
    );
    doseDownController = TextEditingController(
      text: doseDownAmount.toStringAsFixed(1),
    );
    minController = TextEditingController(
      text: widget.controlHandler.min.toStringAsFixed(1),
    );
    maxController = TextEditingController(
      text: widget.controlHandler.max.toStringAsFixed(1),
    );
  }

  @override
  void dispose() {
    doseUpController.dispose();
    doseDownController.dispose();
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PHControlCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.pendingDoseOrder == null) {
      setState(() {
        doseUpAmount = 0;
        doseDownAmount = 0;
        doseUpController.text = '0.0';
        doseDownController.text = '0.0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final control = widget.controlHandler;
    final pendingOrder = widget.pendingDoseOrder;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'pH Control',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: control.isControlledByAI,
                      onChanged:
                          widget.isLoading
                              ? null
                              : (val) => handleChange(
                                field: 'isControlledByAI',
                                value: val,
                              ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "AI",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Set pH Range',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
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
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
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
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
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
                  (control.isControlledByAI || widget.isLoading)
                      ? null
                      : () {
                        // Add save logic if needed
                      },
              child: const Text('Save pH Range'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Manual Dosing',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: doseUpController,
                    enabled: !widget.disabled && pendingOrder == null,
                    decoration: const InputDecoration(
                      labelText: 'pH Up Amount (mL)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (val) {
                      setState(() {
                        doseUpAmount = double.tryParse(val) ?? 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // FIX: Wrap in Flexible or give fixed width
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed:
                        (!widget.disabled &&
                                pendingOrder == null &&
                                doseUpAmount > 0)
                            ? () =>
                                widget.setDoseHandler(DoseType.up, doseUpAmount)
                            : null,
                    child: const Text(
                      'Schedule pH UP',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: doseDownController,
                    enabled: !widget.disabled && pendingOrder == null,
                    decoration: const InputDecoration(
                      labelText: 'pH Down Amount (mL)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (val) {
                      setState(() {
                        doseDownAmount = double.tryParse(val) ?? 0;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed:
                        (!widget.disabled &&
                                pendingOrder == null &&
                                doseDownAmount > 0)
                            ? () => widget.setDoseHandler(
                              DoseType.down,
                              doseDownAmount,
                            )
                            : null,
                    child: const Text(
                      'Schedule pH DOWN',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Note: Dosing commands are sent to hardware after a 10-minute delay, allowing cancellation.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
