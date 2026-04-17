class WeightDisputeEntity {
  final int id;
  final String changeWeight;
  final num weightAmount;
  final String forwardDisputeAmount;
  final String reverseDisputeAmount;
  final String status;
  final List<String>? urls;
  final DateTime? uploadedAt;
  final dynamic sorterImages;
  final int? daysLeft;
  final DateTime? disputeWindowEndsAt;

  WeightDisputeEntity({
    required this.id,
    required this.changeWeight,
    required this.weightAmount,
    required this.forwardDisputeAmount,
    required this.reverseDisputeAmount,
    required this.status,
    this.urls,
    this.uploadedAt,
    this.sorterImages,
    this.daysLeft,
    this.disputeWindowEndsAt,
  });
}
