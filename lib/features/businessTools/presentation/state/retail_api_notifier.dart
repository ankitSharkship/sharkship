import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/businessTools/domain/entities/retail_api_details_entity.dart';
import 'business_tools_providers.dart';

part 'retail_api_notifier.g.dart';

@riverpod
class RetailApiNotifier extends _$RetailApiNotifier {
  @override
  FutureOr<RetailApiDetailsEntity> build() async {
    final result = await ref.read(getRetailApiDetailsUseCaseProvider).call();
    return result.fold(
      (l) => throw l.message,
      (r) => r,
    );
  }
}
