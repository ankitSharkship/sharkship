import 'package:sharkship/core/charts/models/chart_point.dart';

class ChartMapper {
  static List<ChartPoint> fromApi(List<dynamic> json) {
    return json.map((e) {
      return ChartPoint(
        e['label'],
        (e['value'] as num).toDouble(),
      );
    }).toList();
  }
}