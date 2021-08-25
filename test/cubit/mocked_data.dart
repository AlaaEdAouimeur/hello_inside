import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/data/models/measurement.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';

SensorData mockedSensorData =
    SensorData(measurements: measurmenet, entries: entries);
List<Measurement> measurmenet = [
  Measurement(date: DateTime.now().subtract(Duration(minutes: 20)), value: 10),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 30)), value: 20),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 40)), value: 30),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 50)), value: 40),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 60)), value: 50),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 70)), value: 60),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 80)), value: 70),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 90)), value: 80),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 10)), value: 90),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 11)), value: 100),
  Measurement(date: DateTime.now().subtract(Duration(minutes: 12)), value: 110),
];
List<Entry> entries = [
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 1))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 2))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 3))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 4))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 5))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 6))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 7))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 8))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 9))),
  Entry(
      measurements: measurmenet,
      day: DateTime.now().subtract(Duration(days: 10))),
];
