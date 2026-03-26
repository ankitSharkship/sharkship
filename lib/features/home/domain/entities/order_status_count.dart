import 'package:equatable/equatable.dart';

class OrderStatusCountItem extends Equatable {
  final String status;
  final int count;

  const OrderStatusCountItem({
    required this.status,
    required this.count,
  });

  @override
  List<Object?> get props => [status, count];
}