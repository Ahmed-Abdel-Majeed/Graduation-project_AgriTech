import 'light_system.dart';
import 'water_pump.dart';
import 'tds_control.dart';
import 'ph_control.dart';

class HardwareStatus {
  final int nextExecutionTime;
  final String state;

  HardwareStatus({required this.nextExecutionTime, required this.state});

  factory HardwareStatus.fromJson(Map<String, dynamic> json) => HardwareStatus(
    nextExecutionTime: json['nextExecutionTime'] as int,
    state: json['state'] as String,
  );

  Map<String, dynamic> toJson() => {
    'nextExecutionTime': nextExecutionTime,
    'state': state,
  };
}

class LightSchedule {
  final String startTime;
  final String stopTime;
  final bool isCurrentlyOn;

  LightSchedule({
    required this.startTime,
    required this.stopTime,
    required this.isCurrentlyOn,
  });

  factory LightSchedule.fromJson(Map<String, dynamic> json) => LightSchedule(
    startTime: json['startTime'] as String,
    stopTime: json['stopTime'] as String,
    isCurrentlyOn: json['isCurrentlyOn'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'startTime': startTime,
    'stopTime': stopTime,
    'isCurrentlyOn': isCurrentlyOn,
  };
}

class FarmControl {
  final LightSystem lightSystem;
  final WaterPump waterPump;
  final TDSControl tdsControl;
  final PHControl phControl;

  FarmControl({
    required this.lightSystem,
    required this.waterPump,
    required this.tdsControl,
    required this.phControl,
  });

  factory FarmControl.fromJson(Map<String, dynamic> json) {
    return FarmControl(
      lightSystem: LightSystem.fromJson(json['lightSystem'] ?? {}),
      waterPump: WaterPump.fromJson(json['waterPump'] ?? {}),
      tdsControl: TDSControl.fromJson(json['tdsControl'] ?? {}),
      phControl: PHControl.fromJson(json['phControl'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lightSystem': lightSystem.toJson(),
      'waterPump': waterPump.toJson(),
      'tdsControl': tdsControl.toJson(),
      'phControl': phControl.toJson(),
    };
  }

  FarmControl copyWith({
    LightSystem? lightSystem,
    WaterPump? waterPump,
    TDSControl? tdsControl,
    PHControl? phControl,
  }) {
    return FarmControl(
      lightSystem: lightSystem ?? this.lightSystem,
      waterPump: waterPump ?? this.waterPump,
      tdsControl: tdsControl ?? this.tdsControl,
      phControl: phControl ?? this.phControl,
    );
  }
}
