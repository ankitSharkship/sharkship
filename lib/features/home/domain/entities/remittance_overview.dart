import 'package:equatable/equatable.dart';

class RemittanceOverview extends Equatable {
  final num totalRemittancePaid;
  final num totalCodCollected;
  final num upcomingRemittance;
  final num dueRemittance;

  const RemittanceOverview({
    required this.totalRemittancePaid,
    required this.totalCodCollected,
    required this.upcomingRemittance,
    required this.dueRemittance,
  });

  @override
  List<Object?> get props => [
        totalRemittancePaid,
        totalCodCollected,
        upcomingRemittance,
        dueRemittance,
      ];
}
