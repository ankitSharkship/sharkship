class DateUtilsHelper {
  static Map<String, String> getStartEndUtc({
    required DateTime start,
    required DateTime end,
  }) {
    final startUtc = DateTime.utc(
      start.year,
      start.month,
      start.day,
    );

    final endUtc = DateTime.utc(
      end.year,
      end.month,
      end.day,
      23,
      59,
      59,
      999,
    );

    return {
      'startDate': startUtc.toIso8601String(),
      'endDate': endUtc.toIso8601String(),
    };
  }
}