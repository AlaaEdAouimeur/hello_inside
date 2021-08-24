import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SensorProvider {
  Future<String> getRawData() async {
    String myData = await rootBundle.loadString('assets/values.csv');
    return myData;
  }
}
