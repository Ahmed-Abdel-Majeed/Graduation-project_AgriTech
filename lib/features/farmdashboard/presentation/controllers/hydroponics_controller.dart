import 'package:flutter/material.dart';
import '../../domain/models/control_types.dart';
import '../../domain/repositories/hydroponics_repository.dart';

class HydroponicsController extends ChangeNotifier {
  final HydroponicsRepository repository;

  // State
  bool isLoading = false;
  int dosesCountdown = 0;
  String? error;
  String? snackbarMessage;
  Color snackbarColor = Colors.blue;

  // Control States
  WaterPumpControlType waterPumpControl = WaterPumpControlType(
    isControlledByAI: false,
    isCurrentlyRunning: false,
    durationMinutes: 0,
  );

  PHControlType phControl = PHControlType(
    isControlledByAI: false,
    min: 5.5,
    max: 6.5,
    currentValue: 6.0,
  );

  TDSControlType tdsControl = TDSControlType(
    isControlledByAI: false,
    min: 1.2,
    max: 1.8,
    currentValue: 1.5,
  );

  LightControlType lightControl = LightControlType(
    whiteLight: LightScheduleType(
      startTime: TimeOfDay(hour: 8, minute: 0),
      stopTime: TimeOfDay(hour: 18, minute: 0),
    ),
    growthLight: LightScheduleType(
      startTime: TimeOfDay(hour: 19, minute: 0),
      stopTime: TimeOfDay(hour: 7, minute: 0),
    ),
  );

  List<Map<String, dynamic>> historyLog = [];

  // Pending orders
  PendingDoseOrder? pendingPhDoseOrder;
  PendingDoseOrder? pendingTDSDoseOrder;

  HydroponicsController(this.repository) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      isLoading = true;
      notifyListeners();

      // Load all states
      waterPumpControl = await repository.getWaterPumpControl();
      phControl = await repository.getPHControl();
      tdsControl = await repository.getTDSControl();
      lightControl = await repository.getLightControl();
      historyLog = await repository.getHistoryLog();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  // Water Pump Control
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

  // pH Control
  Future<void> updatePHControl(PHControlType control) async {
    try {
      await repository.updatePHControl(control);
      phControl = control;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> schedulePhDose(DoseType type, double amount) async {
    try {
      await repository.scheduleDose(type, amount);
      pendingPhDoseOrder = PendingDoseOrder(
        type: type,
        amount: amount,
        executeAt: DateTime.now().add(Duration(minutes: 10)),
      );
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> cancelPhDose() async {
    try {
      await repository.cancelDose();
      pendingPhDoseOrder = null;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // TDS Control
  Future<void> updateTDSControl(TDSControlType control) async {
    try {
      await repository.updateTDSControl(control);
      tdsControl = control;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> scheduleTDSDose(double amount) async {
    try {
      await repository.scheduleTDSDose(amount);
      pendingTDSDoseOrder = PendingDoseOrder(
        type: DoseType.up,
        amount: amount,
        executeAt: DateTime.now().add(Duration(minutes: 10)),
      );
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> cancelTDSDose() async {
    try {
      await repository.cancelTDSDose();
      pendingTDSDoseOrder = null;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // Light Control
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

  // History
  Future<void> addHistoryLogEntry(Map<String, dynamic> entry) async {
    try {
      await repository.addHistoryLogEntry(entry);
      historyLog.add(entry);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  // UI Helpers
  void showSnackbar(String message, {Color color = Colors.blue}) {
    snackbarMessage = message;
    snackbarColor = color;
    notifyListeners();
  }
}
