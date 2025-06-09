import 'package:agri/features/farmdashboard/domain/repositories/hydroponics_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/models/ph_control_type.dart';
import '../../domain/models/dose_types.dart';

class PHController extends ChangeNotifier {
  final FarmRepository repository;

  PHControlType phControl = PHControlType(
    isControlledByAI: false,
    min: 5.5,
    max: 6.5,
    currentValue: 6.0,
  );

  bool isLoading = false;
  String? error;
  PendingDoseOrder? pendingPhDoseOrder;

  PHController(this.repository) {
    _initialize();
  }

  get dosesCountdown => null;

  Future<void> _initialize() async {
    try {
      isLoading = true;
      notifyListeners();

      phControl = await repository.getPHControl();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

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
}
