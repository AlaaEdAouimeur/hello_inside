part of 'sensor_cubit.dart';

@immutable
abstract class SensorState extends Equatable {
  const SensorState();
}

class SensorInitial extends SensorState {
  const SensorInitial();

  @override
  List<Object?> get props => [];
}

class SensorLoading extends SensorState {
  const SensorLoading();

  @override
  List<Object?> get props => [];
}

class SensorLoaded extends SensorState {
  final SensorData sensorData;
  const SensorLoaded(this.sensorData);

  List<Object?> get props => [sensorData];
}

class SensorError extends SensorState {
  final String message;
  const SensorError(this.message);

  @override
  List<Object?> get props => [message];
}
