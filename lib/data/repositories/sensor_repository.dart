import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:hello_inside_task/data/data_providers/sensor_provider.dart';
import 'package:hello_inside_task/data/models/sensor_data.dart';
import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/data/models/measurement.dart';
import 'package:intl/intl.dart';

class SensorRepository {
  static final SensorRepository _singleton = SensorRepository._instance();

  factory SensorRepository() {
    return _singleton;
  }

  SensorRepository._instance();

  SensorProvider _sensorProvider = SensorProvider();

  Future<SensorData> fetchSensorData() async {
    String csv = await _sensorProvider.getRawData();
    List<List<dynamic>> rowsAsListOfValues = CsvToListConverter().convert(csv);
    SensorData _sensorData = SensorData.fromList(rowsAsListOfValues);
    List<Entry> _entries = [];
    groupBy(_sensorData.measurements,
            (Measurement m) => DateFormat('M/d/y').format(m.date))
        .forEach((key, value) {
      _entries
          .add(Entry(day: DateFormat("M/d/y").parse(key), measurements: value));
    });
    _sensorData.setEntries(_entries);
    return _sensorData;
  }
}
