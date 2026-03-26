import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ndr_status_summary.dart';
import 'ndr_status_group_model.dart';

part 'ndr_status_summary_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NdrStatusSummaryModel extends NdrStatusSummary {
  @override
  final List<NdrStatusGroupModel> countByNDRStatus;

  const NdrStatusSummaryModel({
    required this.countByNDRStatus,
  }) : super(countByNDRStatus: countByNDRStatus);

  factory NdrStatusSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$NdrStatusSummaryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NdrStatusSummaryModelToJson(this);
}
