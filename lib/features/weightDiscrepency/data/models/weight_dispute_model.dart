import '../../domain/entities/weight_dispute_entity.dart';

class WeightDisputeModel extends WeightDisputeEntity {
  WeightDisputeModel({
    required super.id,
    required super.changeWeight,
    required super.weightAmount,
    required super.forwardDisputeAmount,
    required super.reverseDisputeAmount,
    required super.status,
    super.urls,
    super.uploadedAt,
    super.sorterImages,
    super.daysLeft,
    super.disputeWindowEndsAt,
  });

  factory WeightDisputeModel.fromJson(Map<String, dynamic> json) {
    List<String>? parsedUrls;
    if (json['url'] is List) {
      parsedUrls = List<String>.from(json['url']);
    } else if (json['url'] is String) {
      parsedUrls = [json['url']];
    }

    return WeightDisputeModel(
      id: json['id'],
      changeWeight: json['change_weight']?.toString() ?? '0',
      weightAmount: json['weight_amount'] ?? 0,
      forwardDisputeAmount: json['forward_dispute_amount']?.toString() ?? '0.00',
      reverseDisputeAmount: json['reverse_dispute_amount']?.toString() ?? '0.00',
      status: json['status'] ?? '',
      urls: parsedUrls,
      uploadedAt: json['uploaded_at'] != null 
          ? DateTime.parse(json['uploaded_at']) 
          : null,
      sorterImages: json['sorterImages'],
      daysLeft: json['days_left'],
      disputeWindowEndsAt: json['dispute_window_ends_at'] != null
          ? DateTime.parse(json['dispute_window_ends_at'])
          : null,
    );
  }
}
