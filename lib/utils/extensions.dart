extension isOneSameDay on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

/*extension isAfterPeak on DateTime {
  bool isAfterPeak(DateTime other) {
   this.year == other.year && this.month == other.month && this.da
  }
}
*/