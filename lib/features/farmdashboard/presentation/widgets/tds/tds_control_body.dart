import 'package:agri/features/farmdashboard/domain/models/tds_control.dart';
import 'package:flutter/material.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds/dose_buttons.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds/number_input_field.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds/status_and_control_switch.dart';

class TDSControlBody extends StatefulWidget {
  final TDSControl control;
  final Function(TDSControl) onControlChange;
  final Function(TimeOfDay) onScheduleDose;
  final Function() onCancelDose;
  final bool isLoading;

  const TDSControlBody({
    super.key,
    required this.control,
    required this.onControlChange,
    required this.onScheduleDose,
    required this.onCancelDose,
    required this.isLoading,
  });

  @override
  State<TDSControlBody> createState() => _TDSControlBodyState();
}

class _TDSControlBodyState extends State<TDSControlBody> {
  late TDSControl _localControl;

  @override
  void initState() {
    super.initState();
    _localControl = widget.control;
  }

  void handleChange(String field, dynamic value) {
    setState(() {
      _localControl = TDSControl(
        isControlledByAI: field == 'isControlledByAI' ? value : _localControl.isControlledByAI,
        min: field == 'min' ? value : _localControl.min,
        max: field == 'max' ? value : _localControl.max,
        doseAmount: field == 'doseAmount' ? value : _localControl.doseAmount,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAI = _localControl.isControlledByAI;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          StatusAndControlSwitch(
            status: _localControl.doseAmount > 0 ? 'Dosing' : 'Idle',
            controlledBy: isAI ? 'AI' : 'Manual',
            isLoading: widget.isLoading,
            onControlledByChange: (value) => handleChange('isControlledByAI', value == 'AI'),
          ),
          const SizedBox(height: 30),
          NumberInputField(
            label: 'TDS Min (ppm)',
            initialValue: _localControl.min.toString(),
            enabled: !widget.isLoading && !isAI,
            onChanged: (val) => handleChange('min', double.tryParse(val) ?? _localControl.min),
          ),
          const SizedBox(height: 16),
          NumberInputField(
            label: 'TDS Max (ppm)',
            initialValue: _localControl.max.toString(),
            enabled: !widget.isLoading && !isAI,
            onChanged: (val) => handleChange('max', double.tryParse(val) ?? _localControl.max),
          ),
          const SizedBox(height: 16),
          NumberInputField(
            label: 'Dose Amount (ml)',
            initialValue: _localControl.doseAmount.toString(),
            enabled: !widget.isLoading && !isAI,
            onChanged: (val) => handleChange('doseAmount', double.tryParse(val) ?? _localControl.doseAmount),
          ),
          const SizedBox(height: 16),
          DoseButtons(
            isLoading: widget.isLoading,
            onScheduleDose: widget.onScheduleDose,
            onCancelDose: widget.onCancelDose,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : () => widget.onControlChange(_localControl),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
