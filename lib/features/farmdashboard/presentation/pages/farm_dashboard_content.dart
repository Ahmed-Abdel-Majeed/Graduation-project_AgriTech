import 'package:agri/features/farmdashboard/domain/models/light_control_type.dart';
import 'package:agri/features/farmdashboard/domain/models/tds_control_type.dart';
import 'package:agri/features/farmdashboard/presentation/controllers/ph_controller.dart';
import 'package:agri/features/farmdashboard/presentation/controllers/tds_controller.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/history_log_card.dart';
import 'package:agri/features/farmdashboard/presentation/pages/light_control_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/ph_control_screen.dart';
import 'package:agri/features/farmdashboard/presentation/pages/tds_control_screen.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/water_pump_control_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/history_controller.dart';
import '../controllers/light_controller.dart';
import '../controllers/water_pump_controller.dart';

class FarmDashboardContent extends StatelessWidget {
  final int index ;
  const FarmDashboardContent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return Consumer<WaterPumpController>(
          builder: (context, controller, _) {
            return WaterPumpControlCard(
              getControlHandler: controller.waterPumpControl,
              setControlHandler: controller.updateWaterPumpControl,
              isLoading: controller.isLoading,
            );
          },
        );
      case 1:
        return Consumer<PHController>(
          builder: (context, controller, _) {
            return PHControlScreen(
              controlHandler: controller.phControl,
              setControlHandler: controller.updatePHControl,
              setDoseHandler: controller.schedulePhDose,
              cancelDoseHandler: controller.cancelPhDose,
              isLoading: controller.isLoading,
              pendingDoseOrder: controller.pendingPhDoseOrder,
              // doseCountdown: controller.dosesCountdown,
            );
          },
        );
      case 2:
        return Consumer<TDSController>(
          builder: (context, controller, _) {
            return TDSControlScreen(
  
);

          },
        );
      case 3:
        return Consumer<LightController>(
          builder: (context, controller, _) {
            return LightControlScreen(
              control: controller.lightControl.toMap(),
              onControlChange: (map) =>
                  controller.updateLightControl(LightControlType.fromMap(map)),
              isLoading: controller.isLoading,
            );
          },
        );
      case 4:
        return Consumer<HistoryController>(
          builder: (context, controller, _) {
            return HistoryLogCard(historyLog: controller.historyLog);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}


//  HistoryLogCard(historyLog: controller.historyLog),