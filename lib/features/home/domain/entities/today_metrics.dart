import 'package:equatable/equatable.dart';

class TodayMetrics extends Equatable {
  final int todayOrderCount;
  final int yesterdayOrderCount;
  final double? todayRevenue;
  final double? yesterdayRevenue;

  const TodayMetrics({
    required this.todayOrderCount,
    required this.yesterdayOrderCount,
    this.todayRevenue,
    this.yesterdayRevenue,
  });

  /// Percentage increase in orders from yesterday to today
  double get orderCountPercentageIncrease {
    if (yesterdayOrderCount == 0) {
      return todayOrderCount > 0 ? 100.0 : 0.0;
    }
    return ((todayOrderCount - yesterdayOrderCount) / yesterdayOrderCount) * 100;
  }

  /// Percentage increase in revenue from yesterday to today
  double get revenuePercentageIncrease {
    final tRev = todayRevenue ?? 0.0;
    final yRev = yesterdayRevenue ?? 0.0;
    if (yRev == 0) {
      return tRev > 0 ? 100.0 : 0.0;
    }
    return ((tRev - yRev) / yRev) * 100;
  }

  @override
  List<Object?> get props => [
        todayOrderCount,
        yesterdayOrderCount,
        todayRevenue,
        yesterdayRevenue,
      ];
}
