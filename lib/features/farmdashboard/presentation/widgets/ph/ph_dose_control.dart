import 'package:flutter/material.dart';
import '../../../domain/models/dose_types.dart';

class PHDoseControl extends StatefulWidget {
  final void Function(DoseType type, double amount) setDoseHandler;
  final VoidCallback? cancelDoseHandler;
  final PendingDoseOrder? pendingDoseOrder;
  final bool disabled;
  final bool isLoading;

  const PHDoseControl({
    super.key,
    required this.setDoseHandler,
    this.cancelDoseHandler,
    this.pendingDoseOrder,
    this.disabled = false,
    this.isLoading = false,
  });

  @override
  _PHDoseControlState createState() => _PHDoseControlState();
}

class _PHDoseControlState extends State<PHDoseControl> {
  double doseUpAmount = 0;
  double doseDownAmount = 0;

  late TextEditingController doseUpController;
  late TextEditingController doseDownController;

  @override
  void initState() {
    super.initState();
    doseUpController = TextEditingController(text: doseUpAmount.toStringAsFixed(1));
    doseDownController = TextEditingController(text: doseDownAmount.toStringAsFixed(1));
  }

  @override
  void dispose() {
    doseUpController.dispose();
    doseDownController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PHDoseControl oldWidget) {
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
    final pendingOrder = widget.pendingDoseOrder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Manual Dosing', style: TextStyle(fontWeight: FontWeight.w600)),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) {
                  setState(() {
                    doseUpAmount = double.tryParse(val) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 160,
              child: ElevatedButton(
                onPressed: (!widget.disabled && pendingOrder == null && doseUpAmount > 0)
                    ? () => widget.setDoseHandler(DoseType.up, doseUpAmount)
                    : null,
                child: const Text(
                  'Schedule pH UP',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                onPressed: (!widget.disabled && pendingOrder == null && doseDownAmount > 0)
                    ? () => widget.setDoseHandler(DoseType.down, doseDownAmount)
                    : null,
                child: const Text(
                  'Schedule pH DOWN',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
    );
  }
}
