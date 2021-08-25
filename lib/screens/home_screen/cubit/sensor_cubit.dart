import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/data/repositories/sensor_repository.dart';
import 'package:meta/meta.dart';

part 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  SensorRepository sensorRepository = SensorRepository();
  SensorCubit() : super(SensorInitial());
  Future<void> loadSensorData() async {
    try {
      emit(SensorLoading());
      SensorData _sensorData = await sensorRepository.fetchSensorData();
      emit(SensorLoaded(_sensorData));
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }
}
