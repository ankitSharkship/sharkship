import 'package:equatable/equatable.dart';

class CodData extends Equatable {
  final DateTime date;
  final String codCollection;
  final int codOrderCount;

  const CodData({
    required this.date,
    required this.codCollection,
    required this.codOrderCount,
  });

  @override
  List<Object?> get props => [date, codCollection, codOrderCount];
}
