import '../../domain/entities/tracking_event_entity.dart';

class TrackingEventModel extends TrackingEventEntity {
  const TrackingEventModel({
    super.location,
    super.dateTime,
    super.statusCode,
    super.remark,
  });

  factory TrackingEventModel.fromJson(Map<String, dynamic> json) {
    return TrackingEventModel(
      location: json['location'] as String?,
      dateTime: json['date_time'] != null ? DateTime.tryParse(json['date_time'] as String) : null,
      statusCode: json['status_code'] as String?,
      remark: json['remark'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'date_time': dateTime?.toIso8601String(),
      'status_code': statusCode,
      'remark': remark,
    };
  }
}
