class ChartPoint {
  final String label;
  final double value;

  ChartPoint(this.label, this.value);
}
class ChartDatePoint {
  final DateTime label;
  final double value;

  ChartDatePoint(this.label, this.value);
}


class MultiLinePoint {
  final String label;
  final Map<String, double> values; // key = series name

  MultiLinePoint(this.label, this.values);
}

class MultiRingChartItem {
  final double value;
  final String label;
  final String percentage;

  MultiRingChartItem(this.value, this.label, this.percentage);
}