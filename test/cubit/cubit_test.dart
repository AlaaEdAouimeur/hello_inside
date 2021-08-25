import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/data/repositories/sensor_repository.dart';
import 'package:hello_inside_task/screens/home_screen/cubit/sensor_cubit.dart';
import 'package:mocktail/mocktail.dart';

import 'mocked_data.dart';

class MockSensorRepository extends Mock implements SensorRepository {}

void main() {
  group('SensorCubit test', () {
    late MockSensorRepository mockSensorRepository;
    setUp(() {
      registerFallbackValue(SensorLoaded(mockedSensorData));
      EquatableConfig.stringify = true;

      mockSensorRepository = MockSensorRepository();
    });

    blocTest(
        'GIVEN the SensorCubit WHEN the fetchSensorData is called THEN it should emit Loading , Loaded states',
        build: () {
          when(mockSensorRepository.fetchSensorData)
              .thenAnswer((_) async => mockedSensorData);
          SensorCubit sensorCubit = SensorCubit();
          sensorCubit.sensorRepository = mockSensorRepository;
          return sensorCubit;
        },
        act: (SensorCubit mock) => mock.loadSensorData(),
        expect: () => [SensorLoading(), SensorLoaded(mockedSensorData)]);
    blocTest(
        'GIVEN the SensorCubit WHEN the fetchSensorData has an error THEN it should emit SensorError with message',
        build: () {
          when(mockSensorRepository.fetchSensorData).thenThrow('error');

          SensorCubit sensorCubit = SensorCubit();
          sensorCubit.sensorRepository = mockSensorRepository;
          return sensorCubit;
        },
        act: (SensorCubit mock) => mock.loadSensorData(),
        expect: () => [SensorLoading(), SensorError('error')]);
  });
}
