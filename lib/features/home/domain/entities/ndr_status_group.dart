import 'package:equatable/equatable.dart';
import 'ndr_status_count_item.dart';

class NdrStatusGroup extends Equatable {
  final List<NdrStatusCountItem> ndrOrders;
  final List<NdrStatusCountItem> reattemptOrders;
  final List<NdrStatusCountItem> deliveredOrders;
  final List<NdrStatusCountItem> returnedOrders;

  const NdrStatusGroup({
    required this.ndrOrders,
    required this.reattemptOrders,
    required this.deliveredOrders,
    required this.returnedOrders,
  });

  @override
  List<Object?> get props => [
        ndrOrders,
        reattemptOrders,
        deliveredOrders,
        returnedOrders,
      ];

  // Helper getters for easy count access in UI
  int get totalNdrOrders => _sumList(ndrOrders);
  int get totalReattempted => _sumList(reattemptOrders);
  int get totalDelivered => _sumList(deliveredOrders);
  int get totalReturned => _sumList(returnedOrders);

  int _sumList(List<NdrStatusCountItem> items) {
    return items.fold(0, (sum, item) => sum + int.parse(item.count));
  }
}
