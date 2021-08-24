part of 'sensor_cubit.dart';

@immutable
abstract class SensorState {
  const SensorState();
}

class SensorInitial extends SensorState {
  const SensorInitial();
}

class SensorLoading extends SensorState {
  const SensorLoading();
}

class SensorLoaded extends SensorState {
  final SensorData sensorData;
  const SensorLoaded(this.sensorData);
}

class SensorError extends SensorState {
  final String message;
  const SensorError(this.message);
}
