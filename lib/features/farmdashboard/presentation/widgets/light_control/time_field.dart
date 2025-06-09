import 'package:flutter/material.dart';
class TimeField extends StatefulWidget {
  final String label;
  final String? currentTime;
  final bool isAI;
  final bool isLoading;
  final String fieldKey;
  final Function(String) onChange;

  const TimeField({
    super.key,
    required this.label,
    required this.currentTime,
    required this.isAI,
    required this.isLoading,
    required this.fieldKey,
    required this.onChange,
  });

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentTime ?? '');
  }

  @override
  void didUpdateWidget(covariant TimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentTime != widget.currentTime) {
      _controller.text = widget.currentTime ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.isAI || widget.isLoading
            ? null
            : () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  final formatted =
                      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                  widget.onChange(formatted);
                }
              },
        child: AbsorbPointer(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: widget.label,
              border: const OutlineInputBorder(),
              suffixIcon: widget.isAI ? null : const Icon(Icons.access_time),
            ),
            style: TextStyle(color: widget.isAI ? Colors.grey : null),
            readOnly: true,
          ),
        ),
      ),
    );
  }
}
