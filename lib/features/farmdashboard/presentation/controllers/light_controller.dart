import 'package:agri/features/farmdashboard/domain/repositories/hydroponics_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/models/light_control_type.dart';

class LightController extends ChangeNotifier {
  final FarmRepository repository;

  LightControlType lightControl = LightControlType(
    isControlledByAI: false,
    whiteLight: LightScheduleType(
      startTime: TimeOfDay(hour: 8, minute: 0),
      stopTime: TimeOfDay(hour: 18, minute: 0),
    ),
    growthLight: LightScheduleType(
      startTime: TimeOfDay(hour: 19, minute: 0),
      stopTime: TimeOfDay(hour: 7, minute: 0),
    ),
  );

  bool isLoading = false;
  String? error;

  LightController(this.repository) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      isLoading = true;
      notifyListeners();

      lightControl = await repository.getLightControl();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLightControl(LightControlType control) async {
    try {
      await repository.updateLightControl(control);
      lightControl = control;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
