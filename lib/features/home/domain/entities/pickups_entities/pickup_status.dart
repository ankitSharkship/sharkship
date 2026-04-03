import 'package:equatable/equatable.dart';

class PickupStatus extends Equatable {
  final int count;
  final List<int> orderIds;

  const PickupStatus({
    required this.count,
    required this.orderIds,
  });

  @override
  List<Object?> get props => [count, orderIds];
}