import 'package:intl/intl.dart';

class Measurement {
  DateTime date;
  int value;
  Measurement({
    required this.date,
    required this.value,
  });

  Measurement copyWith({
    DateTime? date,
    int? value,
  }) {
    return Measurement(
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'value': value,
    };
  }

  bool get isOutOfRange => this.value < 80 || this.value > 110;
  factory Measurement.fromList(List<dynamic> list) {
    return Measurement(
      date: DateFormat("dd-MM-yyyy HH:mm").parse(list[0]),
      value: list[1],
    );
  }
}
