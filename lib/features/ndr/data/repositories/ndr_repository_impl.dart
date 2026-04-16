import 'package:sharkship/features/ndr/domain/entity/ndr_reattempt_params.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import '../../domain/entity/ndr_response_entity.dart';
import '../../domain/repositories/ndr_repository.dart';
import '../datasources/ndr_datasource.dart';

class NdrRepositoryImpl implements NdrRepository {
  final NdrDataSource _dataSource;

  NdrRepositoryImpl(this._dataSource);

  @override
  Future<NdrResponseEntity> getNdrOrders(OrderListParams params) {
    return _dataSource.getNdrOrders(params);
  }

  @override
  Future<void> reattemptNdrOrders(NdrReattemptParams params) {
    return _dataSource.reattemptNdrOrders(params);
  }
}
