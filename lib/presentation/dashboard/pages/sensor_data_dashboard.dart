// A data model representing a sensor reading at a specific time.
class SensorDataDashboard {
  final DateTime time;
  final double value;

  SensorDataDashboard(this.time, this.value);

  /// ---- Static pH Data ---- ///
  static List<SensorDataDashboard> getPhData12h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 7.2),
      SensorDataDashboard(now.subtract(const Duration(hours: 9)), 6.8),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 7.5),
      SensorDataDashboard(now.subtract(const Duration(hours: 3)), 6.9),
      SensorDataDashboard(now, 7.3),
    ];
  }

  static List<SensorDataDashboard> getPhData24h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 24)), 100),
      SensorDataDashboard(now.subtract(const Duration(hours: 18)), 300),
      SensorDataDashboard(now.subtract(const Duration(hours: 12)),400),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 700),
      SensorDataDashboard(now, 777),
    ];
  }

  static List<SensorDataDashboard> getPhData7d() {
    final today = DateTime.now();
    return [
      SensorDataDashboard(today.subtract(const Duration(days: 6)), 6.8),
      SensorDataDashboard(today.subtract(const Duration(days: 5)), 6.9),
      SensorDataDashboard(today.subtract(const Duration(days: 4)), 7.0),
      SensorDataDashboard(today.subtract(const Duration(days: 3)), 7.2),
      SensorDataDashboard(today.subtract(const Duration(days: 2)), 7.1),
      SensorDataDashboard(today.subtract(const Duration(days: 1)), 6.9),
      SensorDataDashboard(today, 7.0),
    ];
  }

  /// ---- Static EC Data ---- ///
  static List<SensorDataDashboard> getEcData12h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 400),
      SensorDataDashboard(now.subtract(const Duration(hours: 9)), 500),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 620),
      SensorDataDashboard(now.subtract(const Duration(hours: 3)), 700),
      SensorDataDashboard(now, 800),
    ];
  }

  static List<SensorDataDashboard> getEcData24h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 24)), 420),
      SensorDataDashboard(now.subtract(const Duration(hours: 18)), 480),
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 530),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 600),
      SensorDataDashboard(now, 650),
    ];
  }

  static List<SensorDataDashboard> getEcData7d() {
    final today = DateTime.now();
    return [
      SensorDataDashboard(today.subtract(const Duration(days: 6)), 480),
      SensorDataDashboard(today.subtract(const Duration(days: 5)), 500),
      SensorDataDashboard(today.subtract(const Duration(days: 4)), 520),
      SensorDataDashboard(today.subtract(const Duration(days: 3)), 560),
      SensorDataDashboard(today.subtract(const Duration(days: 2)), 600),
      SensorDataDashboard(today.subtract(const Duration(days: 1)), 650),
      SensorDataDashboard(today, 700),
    ];
  }

  /// ---- Static Water Temperature Data ---- ///
  static List<SensorDataDashboard> getWaterTemperatureData12h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 20.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 9)), 22.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 25.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 3)), 30.0),
      SensorDataDashboard(now, 26.0),
    ];
  }

  static List<SensorDataDashboard> getWaterTemperatureData24h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 24)), 19.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 18)), 21.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 24.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 60.5),
      SensorDataDashboard(now, 25.5),
    ];
  }

  static List<SensorDataDashboard> getWaterTemperatureData7d() {
    final today = DateTime.now();
    return [
      SensorDataDashboard(today.subtract(const Duration(days: 6)), 21.5),
      SensorDataDashboard(today.subtract(const Duration(days: 5)), 22.0),
      SensorDataDashboard(today.subtract(const Duration(days: 4)), 23.0),
      SensorDataDashboard(today.subtract(const Duration(days: 3)), 24.0),
      SensorDataDashboard(today.subtract(const Duration(days: 2)), 23.5),
      SensorDataDashboard(today.subtract(const Duration(days: 1)), 24.5),
      SensorDataDashboard(today, 25.0),
    ];
  }

  /// ---- Static Air Temperature Data ---- ///
  static List<SensorDataDashboard> getAirTemperatureData12h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 18.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 9)), 20.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 23.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 3)), 21.0),
      SensorDataDashboard(now, 24.0),
    ];
  }

  static List<SensorDataDashboard> getAirTemperatureData24h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 24)), 17.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 18)), 19.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 22.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 21.5),
      SensorDataDashboard(now, 23.0),
    ];
  }

  static List<SensorDataDashboard> getAirTemperatureData7d() {
    final today = DateTime.now();
    return [
      SensorDataDashboard(today.subtract(const Duration(days: 6)), 19.0),
      SensorDataDashboard(today.subtract(const Duration(days: 5)), 20.0),
      SensorDataDashboard(today.subtract(const Duration(days: 4)), 21.0),
      SensorDataDashboard(today.subtract(const Duration(days: 3)), 22.0),
      SensorDataDashboard(today.subtract(const Duration(days: 2)), 21.0),
      SensorDataDashboard(today.subtract(const Duration(days: 1)), 22.5),
      SensorDataDashboard(today, 23.0),
    ];
  }

  /// ---- Static Humidity Data ---- ///
  static List<SensorDataDashboard> getHumidityData12h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 45.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 9)), 50.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 48.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 3)), 53.0),
      SensorDataDashboard(now, 66.0),
    ];
  }

  static List<SensorDataDashboard> getHumidityData24h() {
    final now = DateTime.now();
    return [
      SensorDataDashboard(now.subtract(const Duration(hours: 24)), 40.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 18)), 45.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 12)), 50.0),
      SensorDataDashboard(now.subtract(const Duration(hours: 6)), 55.0),
      SensorDataDashboard(now, 60.0),
    ];
  }

  static List<SensorDataDashboard> getHumidityData7d() {
    final today = DateTime.now();
    return [
      SensorDataDashboard(today.subtract(const Duration(days: 6)), 40.0),
      SensorDataDashboard(today.subtract(const Duration(days: 5)), 45.0),
      SensorDataDashboard(today.subtract(const Duration(days: 4)), 48.0),
      SensorDataDashboard(today.subtract(const Duration(days: 3)), 52.0),
      SensorDataDashboard(today.subtract(const Duration(days: 2)), 50.0),
      SensorDataDashboard(today.subtract(const Duration(days: 1)), 55.0),
      SensorDataDashboard(today, 60.0),
    ];
  }


}
