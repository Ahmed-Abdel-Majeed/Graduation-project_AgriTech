import 'package:flutter/material.dart';
import '../../domain/models/water_pump_control_type.dart';
import '../../domain/models/ph_control_type.dart';
import '../../domain/models/tds_control_type.dart';
import '../../domain/models/light_control_type.dart';
import '../../domain/models/dose_types.dart';
import '../../domain/repositories/hydroponics_repository.dart';

class FarmRepositoryImpl implements FarmRepository {
  // HydroponicsRepositoryImpl();

  WaterPumpControlType _waterPumpControl = WaterPumpControlType(
    isControlledByAI: false,
    isCurrentlyRunning: false,
    durationMinutes: 0,
  );

  // PHControlType _phControl = PHControlType(
  //   isControlledByAI: false,
  //   min: 5.5,
  //   max: 6.5,
  //   currentValue: 6.0,
  // );

  TDSControlType _tdsControl = TDSControlType(
    isControlledByAI: false,
    min: 1.2,
    max: 1.8,
    currentValue: 1.5,
  );

  LightControlType _lightControl = LightControlType(
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

  final List<Map<String, dynamic>> _historyLog = [];

  @override
  Future<WaterPumpControlType> getWaterPumpControl() async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 500));
    return _waterPumpControl;
  }

  @override
  Future<void> updateWaterPumpControl(WaterPumpControlType control) async {
    await Future.delayed(Duration(milliseconds: 500));
    _waterPumpControl = control;
    _addHistoryEntry('Water Pump Control Updated');
  }

  // @override
  // Future<PHControlType> getPHControl() async {
  //   await Future.delayed(Duration(milliseconds: 500));
  //   return _phControl;
  // }

  // @override
  // Future<void> updatePHControl(PHControlType control) async {
  //   await Future.delayed(Duration(milliseconds: 500));
  //   _phControl = control;
  //   _addHistoryEntry('pH Control Updated');
  // }

  @override
  Future<void> scheduleDose(DoseType type, double amount) async {
    await Future.delayed(Duration(milliseconds: 500));
    _addHistoryEntry(
      'pH ${type == DoseType.up ? "Up" : "Down"} Dose Scheduled: $amount mL',
    );
  }

  @override
  Future<void> cancelDose() async {
    await Future.delayed(Duration(milliseconds: 500));
    _addHistoryEntry('pH Dose Cancelled');
  }

  @override
  Future<TDSControlType> getTDSControl() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _tdsControl;
  }

  @override
  Future<void> updateTDSControl(TDSControlType control) async {
    await Future.delayed(Duration(milliseconds: 500));
    _tdsControl = control;
    _addHistoryEntry('TDS Control Updated');
  }

  @override
  Future<void> scheduleTDSDose(double amount) async {
    await Future.delayed(Duration(milliseconds: 500));
    _addHistoryEntry('TDS Dose Scheduled: $amount mL');
  }

  @override
  Future<void> cancelTDSDose() async {
    await Future.delayed(Duration(milliseconds: 500));
    _addHistoryEntry('TDS Dose Cancelled');
  }

  @override
  Future<LightControlType> getLightControl() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _lightControl;
  }

  @override
  Future<void> updateLightControl(LightControlType control) async {
    await Future.delayed(Duration(milliseconds: 500));
    _lightControl = control;
    _addHistoryEntry('Light Control Updated');
  }

  @override
  Future<List<Map<String, dynamic>>> getHistoryLog() async {
    await Future.delayed(Duration(milliseconds: 500));
    return _historyLog;
  }

  @override
  Future<void> addHistoryLogEntry(Map<String, dynamic> entry) async {
    await Future.delayed(Duration(milliseconds: 500));
    _addHistoryEntry(entry['action'] as String);
  }

  void _addHistoryEntry(String action) {
    _historyLog.add({
      'id': _historyLog.length + 1,
      'timestamp': DateTime.now(),
      'action': action,
      'source': 'manual',
    });
  }
}
