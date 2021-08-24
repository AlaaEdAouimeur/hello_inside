import 'package:intl/intl.dart';

extension isOneSameDay on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  bool isSdsameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

extension formateDate on DateTime {
  String get toDay => DateFormat('EEE, M/d/y').format(this);
  String get toTimeOfDay => DateFormat(DateFormat.HOUR24_MINUTE).format(this);
}

extension convertDate on DateTime {
  int get inMinutes => this.hour * 60 + this.minute;
  int get toChartMinutes => this.inMinutes;
}
/*extension isAfterPeak on DateTime {
  bool isAfterPeak(DateTime other) {
   this.year == other.year && this.month == other.month && this.da
  }
}
*/