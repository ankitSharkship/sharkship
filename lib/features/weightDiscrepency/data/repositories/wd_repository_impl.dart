import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

import '../../domain/entities/wd_response_entity.dart';
import '../../domain/repositories/wd_repository.dart';
import '../datasources/wd_datasource.dart';
import '../models/wd_model.dart';

class WdRepositoryImpl implements WdRepository {
  final WdDataSource dataSource;

  WdRepositoryImpl(this.dataSource);

  @override
  Future<WdResponseEntity> getWeightDiscrepancies(
    OrderListParams params,
  ) async {
    final result = await dataSource.getWeightDiscrepancies(params);

    return WdResponseEntity(
      totalCount: result['totalCount'],
      items: result['items'],
    );
  }

  @override
  Future<void> uploadDispute({
    required String trackingId,
    required List<String> filePaths,
  }) async {
    await dataSource.uploadDispute(
      trackingId: trackingId,
      filePaths: filePaths,
    );
  }
}
