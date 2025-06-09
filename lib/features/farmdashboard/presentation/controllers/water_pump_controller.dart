import 'package:agri/features/farmdashboard/domain/repositories/hydroponics_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/models/water_pump_control_type.dart';

class WaterPumpController extends ChangeNotifier {
  final FarmRepository repository;

  WaterPumpControlType waterPumpControl = WaterPumpControlType(
    isControlledByAI: false,
    isCurrentlyRunning: false,
    durationMinutes: 0,
  );

  bool isLoading = false;
  String? error;

  WaterPumpController(this.repository) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      isLoading = true;
      notifyListeners();

      waterPumpControl = await repository.getWaterPumpControl();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateWaterPumpControl(WaterPumpControlType control) async {
    try {
      await repository.updateWaterPumpControl(control);
      waterPumpControl = control;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
