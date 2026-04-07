import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/remittance_overview.dart';

part 'remittance_overview_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RemittanceOverviewResponseModel {
  @JsonKey(name: 'remittanceDetails')
  final RemittanceOverviewModel remittanceDetails;

  const RemittanceOverviewResponseModel({required this.remittanceDetails});

  factory RemittanceOverviewResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RemittanceOverviewResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemittanceOverviewResponseModelToJson(this);
}

@JsonSerializable()
class RemittanceOverviewModel extends RemittanceOverview {
  @override
  @JsonKey(name: 'total_remittance_paid', fromJson: _numFromJson)
  final num totalRemittancePaid;

  @override
  @JsonKey(name: 'total_cod_collected', fromJson: _numFromJson)
  final num totalCodCollected;

  @override
  @JsonKey(name: 'upcoming_remittance', fromJson: _numFromJson)
  final num upcomingRemittance;

  @override
  @JsonKey(name: 'due_remittance', fromJson: _numFromJson)
  final num dueRemittance;

  const RemittanceOverviewModel({
    required this.totalRemittancePaid,
    required this.totalCodCollected,
    required this.upcomingRemittance,
    required this.dueRemittance,
  }) : super(
          totalRemittancePaid: totalRemittancePaid,
          totalCodCollected: totalCodCollected,
          upcomingRemittance: upcomingRemittance,
          dueRemittance: dueRemittance,
        );

  factory RemittanceOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$RemittanceOverviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemittanceOverviewModelToJson(this);

  static num _numFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? 0;
    return 0;
  }
}
