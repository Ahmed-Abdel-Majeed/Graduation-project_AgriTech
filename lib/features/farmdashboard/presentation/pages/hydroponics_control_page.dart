import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/hydroponics_controller.dart';
import '../widgets/water_pump_control_card.dart';
import '../widgets/ph_control_card.dart';
import '../widgets/tds_control_card.dart';
import '../widgets/light_control_card.dart';
import '../widgets/hardware_status.dart';
import '../widgets/history_log_card.dart';
import '../../domain/models/control_types.dart';

class HydroponicsControlPage extends StatelessWidget {
  const HydroponicsControlPage({super.key});

  Map<String, dynamic> phControlToMap(PHControlType control) => {
        'controlledBy': control.isControlledByAI,
        'min': control.min,
        'max': control.max,
        'currentValue': control.currentValue,
        'status': 'Active',
      };

  PHControlType mapToPHControl(Map<String, dynamic> map) => PHControlType(
        isControlledByAI: map['controlledBy'] ?? false,
        min: map['min'] ?? 5.5,
        max: map['max'] ?? 6.5,
        currentValue: map['currentValue'] ?? 6.0,
      );

  Map<String, dynamic> tdsControlToMap(TDSControlType control) => {
        'controlledBy': control.isControlledByAI,
        'min': control.min,
        'max': control.max,
        'currentValue': control.currentValue,
        'status': 'Active',
      };

  TDSControlType mapToTDSControl(Map<String, dynamic> map) => TDSControlType(
        isControlledByAI: map['controlledBy'] ?? false,
        min: map['min'] ?? 1.2,
        max: map['max'] ?? 1.8,
        currentValue: map['currentValue'] ?? 1.5,
      );

  Map<String, dynamic> lightControlToMap(LightControlType control) => {
        'controlledBy': control.isControlledByAI,
        'onTime':
            '${control.whiteLight.startTime.hour.toString().padLeft(2, '0')}:${control.whiteLight.startTime.minute.toString().padLeft(2, '0')}',
        'offTime':
            '${control.whiteLight.stopTime.hour.toString().padLeft(2, '0')}:${control.whiteLight.stopTime.minute.toString().padLeft(2, '0')}',
        'intensity': 100,
        'status': 'Active',
      };

  LightControlType mapToLightControl(Map<String, dynamic> map) =>
      LightControlType(
        whiteLight: LightScheduleType(
          startTime: TimeOfDay(hour: 8, minute: 0),
          stopTime: TimeOfDay(hour: 18, minute: 0),
        ),
        growthLight: LightScheduleType(
          startTime: TimeOfDay(hour: 19, minute: 0),
          stopTime: TimeOfDay(hour: 7, minute: 0),
        ),
        isControlledByAI: map['controlledBy'] ?? false,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<HydroponicsController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(
            child: Text(
              'Error: ${controller.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Hydroponics Control'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WaterPumpControlCard(
                  getControlHandler: controller.waterPumpControl,
                  setControlHandler: controller.updateWaterPumpControl,
                  isLoading: controller.isLoading,
                ),
                const SizedBox(height: 16),
                PHControlCard(
                  controlHandler: controller.phControl,
                  setControlHandler: (control) {
                    controller.updatePHControl(control);
                  },
                  setDoseHandler: (type, amount) {
                    controller.schedulePhDose(type, amount);
                  },
                  cancelDoseHandler: () {
                    controller.cancelPhDose();
                  },
                  isLoading: controller.isLoading,
                  pendingDoseOrder: controller.pendingPhDoseOrder,
                  doseCountdown: controller.dosesCountdown,
                ),
                const SizedBox(height: 16),
                TDSControlCard(
                  control: tdsControlToMap(controller.tdsControl),
                  onControlChange: (map) =>
                      controller.updateTDSControl(mapToTDSControl(map)),
                  onScheduleDose: (time) => controller.scheduleTDSDose(10),
                  onCancelDose: controller.cancelTDSDose,
                  isLoading: controller.isLoading,
                ),
                const SizedBox(height: 16),
                LightControlCard(
                  control: lightControlToMap(controller.lightControl),
                  onControlChange: (map) =>
                      controller.updateLightControl(mapToLightControl(map)),
                  isLoading: controller.isLoading,
                ),
                const SizedBox(height: 16),
                const HardwareStatus(),
                const SizedBox(height: 16),
                HistoryLogCard(
                  historyLog: controller.historyLog,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
