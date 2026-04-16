import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/ndr/data/datasources/ndr_datasource.dart';
import 'package:sharkship/features/ndr/data/repositories/ndr_repository_impl.dart';
import 'package:sharkship/features/ndr/domain/repositories/ndr_repository.dart';
import 'package:sharkship/features/ndr/domain/usecases/get_ndr_orders_usecase.dart';
import 'package:sharkship/features/ndr/domain/usecases/reattempt_ndr_orders_usecase.dart';

part 'ndr_provider.g.dart';

@riverpod
NdrDataSource ndrDataSource(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NdrDataSource(dioClient.dio);
}

@riverpod
NdrRepository ndrRepository(Ref ref) {
  final dataSource = ref.watch(ndrDataSourceProvider);
  return NdrRepositoryImpl(dataSource);
}

@riverpod
GetNdrOrdersUseCase getNdrOrdersUseCase(Ref ref) {
  final repository = ref.watch(ndrRepositoryProvider);
  return GetNdrOrdersUseCase(repository);
}

@riverpod
ReattemptNdrOrdersUseCase reattemptNdrOrdersUseCase(Ref ref) {
  final repository = ref.watch(ndrRepositoryProvider);
  return ReattemptNdrOrdersUseCase(repository);
}
