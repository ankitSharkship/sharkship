import 'package:equatable/equatable.dart';

class DatewiseNdrCount extends Equatable {
  final DateTime date;
  final int count;

  const DatewiseNdrCount({
    required this.date,
    required this.count,
  });

  @override
  List<Object?> get props => [date, count];
}
