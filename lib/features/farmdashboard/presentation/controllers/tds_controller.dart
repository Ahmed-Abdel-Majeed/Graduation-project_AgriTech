import 'package:agri/features/farmdashboard/domain/repositories/hydroponics_repository.dart';
import 'package:flutter/material.dart';
import '../../domain/models/tds_control_type.dart';
import '../../domain/models/dose_types.dart';

class TDSController extends ChangeNotifier {
  final FarmRepository repository;

  TDSControlType tdsControl = TDSControlType(
    isControlledByAI: false,
    min: 1.2,
    max: 1.8,
    currentValue: 1.5,
  );

  bool isLoading = false;
  String? error;
  PendingDoseOrder? pendingTDSDoseOrder;

  TDSController(this.repository) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      isLoading = true;
      notifyListeners();

      tdsControl = await repository.getTDSControl();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

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
}
