import 'package:equatable/equatable.dart';

class DatewiseRtoCount extends Equatable {
  final DateTime date;
  final int count;

  const DatewiseRtoCount({
    required this.date,
    required this.count,
  });

  @override
  List<Object?> get props => [date, count];
}
