import 'package:agri/data/repositories/sensor_repository.dart';
import 'package:agri/domain/entities/sensor_data.dart'; 
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  final SensorRepository sensorRepository;  

  SensorCubit(this.sensorRepository) : super(SensorInitial());

  Future<void> fetchLast200SensorData() async {
    try {
      emit(SensorLoading());
      final sensorData = await sensorRepository.getLast200SensorData();  
      emit(SensorLoaded(sensorData));
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }

  Future<void> saveSensorData(int timestamp, double temperature, double humidity) async {
    try {
      emit(SensorSaving());
      final response = await sensorRepository.saveSensorData(timestamp, temperature, humidity); 
      fetchLast200SensorData();
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }
}
