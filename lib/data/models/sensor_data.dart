import 'package:flutter/foundation.dart';
import 'package:hello_inside_task/data/models/entry.dart';
import 'package:hello_inside_task/data/models/measurement.dart';

class SensorData {
  List<Measurement> measurements;
  List<Entry> entries = [];
  SensorData({required this.measurements, this.entries = const []});

  SensorData copyWith({List<Measurement>? measurements, List<Entry>? entries}) {
    return SensorData(
        measurements: measurements ?? this.measurements,
        entries: entries ?? this.entries);
  }

  factory SensorData.fromList(List<List<dynamic>> list) {
    list.removeAt(0);
    return SensorData(
        measurements:
            List<Measurement>.from(list.map((e) => Measurement.fromList(e))));
  }
  void setEntries(List<Entry> entries) => this.entries = entries;
  @override
  String toString() => 'Entries(entries: $entries)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SensorData && listEquals(other.entries, entries);
  }

  @override
  int get hashCode => entries.hashCode;
}
