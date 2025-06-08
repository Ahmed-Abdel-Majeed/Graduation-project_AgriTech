import 'package:agri/features/farmdashboard/domain/models/light_control_type.dart';
import 'package:agri/features/farmdashboard/domain/models/tds_control_type.dart';
import 'package:agri/features/farmdashboard/presentation/controllers/farm_controller.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/history_log_card.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/light_control_card.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/ph_control_card.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/tds_control_card.dart';
import 'package:agri/features/farmdashboard/presentation/widgets/water_pump_control_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmDashboardContent extends StatelessWidget {
  final int index = 3;
  const FarmDashboardContent({super.key});

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

        return Container(
          child:
              index == 0
                  ? WaterPumpControlCard(
                    getControlHandler: controller.waterPumpControl,
                    setControlHandler: controller.updateWaterPumpControl,
                    isLoading: controller.isLoading,
                  )
                  : index == 1
                  ? PHControlCard(
                    controlHandler: controller.phControl,
                    setControlHandler: controller.updatePHControl,
                    setDoseHandler: controller.schedulePhDose,
                    cancelDoseHandler: controller.cancelPhDose,
                    isLoading: controller.isLoading,
                    pendingDoseOrder: controller.pendingPhDoseOrder,
                    doseCountdown: controller.dosesCountdown,
                  )
                  : index == 2
                  ? TDSControlCard(
                    control: controller.tdsControl.toMap(),
                    onControlChange:
                        (map) => controller.updateTDSControl(
                          TDSControlType.fromMap(map),
                        ),
                    onScheduleDose: (time) => controller.scheduleTDSDose(10),
                    onCancelDose: controller.cancelTDSDose,
                    isLoading: controller.isLoading,
                  )
                  : index == 3
                  ? LightControl(
                    control: controller.lightControl.toMap(),
                    onControlChange:
                        (map) => controller.updateLightControl(
                          LightControlType.fromMap(map),
                        ),
                    isLoading: controller.isLoading,
                  )
                  : index == 4
                  ? HistoryLogCard(historyLog: controller.historyLog)
                  : Container(),
        );
      },
    );
  }
}
//  HistoryLogCard(historyLog: controller.historyLog),