import '../models/water_pump_control_type.dart';
import '../models/ph_control_type.dart';
import '../models/tds_control_type.dart';
import '../models/light_control_type.dart';
import '../models/dose_types.dart';

abstract class HydroponicsRepository {
  // Water Pump
  Future<WaterPumpControlType> getWaterPumpControl();
  Future<void> updateWaterPumpControl(WaterPumpControlType control);

  // pH Control
  Future<PHControlType> getPHControl();
  Future<void> updatePHControl(PHControlType control);
  Future<void> scheduleDose(DoseType type, double amount);
  Future<void> cancelDose();

  // TDS Control
  Future<TDSControlType> getTDSControl();
  Future<void> updateTDSControl(TDSControlType control);
  Future<void> scheduleTDSDose(double amount);
  Future<void> cancelTDSDose();

  // Light Control
  Future<LightControlType> getLightControl();
  Future<void> updateLightControl(LightControlType control);

  // History
  Future<List<Map<String, dynamic>>> getHistoryLog();
  Future<void> addHistoryLogEntry(Map<String, dynamic> entry);
}
