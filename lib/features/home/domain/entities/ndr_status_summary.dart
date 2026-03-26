import 'package:equatable/equatable.dart';
import 'ndr_status_group.dart';

class NdrStatusSummary extends Equatable {
  final List<NdrStatusGroup> countByNDRStatus;

  const NdrStatusSummary({required this.countByNDRStatus});

  @override
  List<Object?> get props => [countByNDRStatus];
}
