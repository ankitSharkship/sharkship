import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/weightDiscrepency/domain/usecases/upload_dispute_usecase.dart';
import '../../data/datasources/wd_datasource.dart';
import '../../data/repositories/wd_repository_impl.dart';
import '../../domain/repositories/wd_repository.dart';
import '../../domain/usecases/get_wd_usecase.dart';

part 'wd_providers.g.dart';

@riverpod
WdDataSource wdDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return WdDataSource(dio);
}

@riverpod
WdRepository wdRepository(Ref ref) {
  final dataSource = ref.watch(wdDataSourceProvider);
  return WdRepositoryImpl(dataSource);
}

@riverpod
GetWdUsecase getWdUsecase(Ref ref) {
  final repository = ref.watch(wdRepositoryProvider);
  return GetWdUsecase(repository);
}

@riverpod
UploadDisputeUseCase uploadDisputeUseCase(Ref ref) {
  return UploadDisputeUseCase(ref.watch(wdRepositoryProvider));
}
