class ChartPoint {
  final String label;
  final double value;

  ChartPoint(this.label, this.value);
}

class MultiLinePoint {
  final String label;
  final Map<String, double> values; // key = series name

  MultiLinePoint(this.label, this.values);
}