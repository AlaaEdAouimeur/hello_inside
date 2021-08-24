import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hello_inside_task/data/models/measurement.dart';
import 'package:hello_inside_task/data/models/spike.dart';

import 'package:intl/intl.dart';

class Entry {
  List<Measurement> measurements;
  DateTime day;
  Entry({required this.measurements, required this.day});

  Entry copyWith({
    List<Measurement>? measurements,
    DateTime? day,
    int? percentage,
  }) {
    return Entry(
      measurements: measurements ?? this.measurements,
      day: day ?? this.day,
    );
  }

  factory Entry.fromList(Map<String, List<Measurement>> map, String date) {
    return Entry(
      day: DateFormat("M/d/y").parse(date),
      measurements: map[date] ?? [],
    );
  }
  int get getPercentage =>
      ((measurements.where((element) => !element.isOutOfRange).length /
                  measurements.length) *
              100)
          .round();

  List<Spike> get countSpikes {
    List<Spike> _spikes = [];
    measurements.forEachIndexed((index, element) {
      if (element.value > 110) {
        DateTime from = element.date.subtract(Duration(minutes: 15));

        Measurement _m = measurements.firstWhere(
            (m) => m.date.isAfter(from) || m.date.isAtSameMomentAs(from),
            orElse: () => measurements.first);

        if (element.value - _m.value >= 20) {
          _spikes.add(Spike(
              dateTimeRange: DateTimeRange(start: _m.date, end: element.date),
              spikeValue: element.value - _m.value));
        }
      }
    });

    return _spikes;
  }
}



/*  int get countSpikes {
//    measurements.where((element) => element.value > 110)

    measurements.forEachIndexed((index, element) {
      if (element.value > 110) {
        DateTime from = element.date.subtract(Duration(minutes: 20));
        List<Measurement> list = measurements
            .where((e) => e.date.isBefore(element.date) && e.date.isAfter(from))
            .toList();
        if (element.value - list.first.value >= 20)
          print('found one ' +
              element.date.toString() +
              ' from  ' +
              list.first.date.toString());
        else
          print('nope');
      }
    });
    return 0;
  }*/