import 'package:sharkship/features/wallet/data/datasources/phonepe_datasource.dart';
import 'package:sharkship/features/wallet/domain/repositories/phonepe_repository.dart';

class PhonePeRepositoryImpl implements PhonePeRepository {
  final PhonePeDataSource dataSource;

  PhonePeRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>?> startPayment({
    required String request,
    required String flowId,
  }) async {
    await dataSource.init(
      environment: "SANDBOX",
      merchantId: "M23GHPG4LKDT5_2511291724",
      flowId: flowId,
      enableLogs: true,
    );

    return await dataSource.startTransaction(request: request);
  }
}
