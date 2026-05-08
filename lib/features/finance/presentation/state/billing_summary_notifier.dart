import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/finance/presentation/state/bs_filters_tab_provider.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import '../../domain/entities/billing_cycle_entity.dart';
import '../../domain/usecases/get_billing_cycles.dart';
import '../../domain/usecases/download_billing_sheet.dart';
import '../../domain/usecases/sync_billing_cycles.dart';
import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';

part 'billing_summary_notifier.g.dart';

class BillingSummaryState {
  final BillingSummaryEntity? data;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  BillingSummaryState({
    this.data,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  BillingSummaryState copyWith({
    BillingSummaryEntity? data,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return BillingSummaryState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}

class BillingSummaryParams {
  final int total;
  final int skip;
  final String startDate;
  final String endDate;
  final String dateQuery;
  final String? status;

  BillingSummaryParams({
    required this.total,
    required this.skip,
    required this.startDate,
    required this.endDate,
    required this.dateQuery,
    this.status,
  });

  BillingSummaryParams copyWith({
    int? total,
    int? skip,
    String? startDate,
    String? endDate,
    String? dateQuery,
    String? status,
  }) {
    return BillingSummaryParams(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateQuery: dateQuery ?? this.dateQuery,
      status: status ?? this.status,
    );
  }
}

@riverpod
class BillingSummaryNotifier extends _$BillingSummaryNotifier {
  @override
  Future<BillingSummaryState> build() async {
    final dashboardDate = ref.watch(dashboardDateProvider);
    final dateQuery = ref.read(bsDateQueryTypeFilterProvider);
    final status = ref.read(bsStatusTypeFilterProvider);
    final params = BillingSummaryParams(
      total: 10,
      skip: 0,
      startDate: dashboardDate.start.toIso8601String(),
      endDate: dashboardDate.end.toIso8601String(),
      dateQuery: dateQuery,
      status: status,
    );

    final result = await _fetchFromUseCase(params);
    return result.fold(
      (l) => throw l.message,
      (r) => BillingSummaryState(data: r),
    );
  }

  Future<dynamic> _fetchFromUseCase(BillingSummaryParams params) {
    return ref
        .read(getBillingCyclesUseCaseProvider)
        .call(
          total: params.total,
          skip: params.skip,
          startDate: params.startDate,
          endDate: params.endDate,
          dateQuery: params.dateQuery,
          status: params.status,
        );
  }

  Future<void> fetchBillingCycles() async {
    final dashboardDate = ref.read(dashboardDateProvider);
    final currentQuery = ref.read(bsDateQueryTypeFilterProvider);
    final status = ref.read(bsStatusTypeFilterProvider);
    state = AsyncData(
      state.value?.copyWith(isLoading: true, error: null) ??
          BillingSummaryState(isLoading: true),
    );

    final params = BillingSummaryParams(
      total: 10,
      skip: 0,
      startDate: dashboardDate.start.toIso8601String(),
      endDate: dashboardDate.end.toIso8601String(),
      dateQuery: currentQuery,
      status: status,
    );

    try {
      final result = await _fetchFromUseCase(params);
      result.fold(
        (l) => state = AsyncError(l.message, StackTrace.current),
        (r) => state = AsyncData(BillingSummaryState(data: r)),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || current.data == null)
      return;

    final totalCount = current.data!.totalCount;
    final currentList = current.data!.billingCycles;

    if (currentList.length >= totalCount) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final dashboardDate = ref.read(dashboardDateProvider);
      final currentQuery = ref.read(bsDateQueryTypeFilterProvider);
      final status = ref.read(bsStatusTypeFilterProvider);
      final params = BillingSummaryParams(
        total: 10,
        skip: currentList.length,
        startDate: dashboardDate.start.toIso8601String(),
        endDate: dashboardDate.end.toIso8601String(),
        dateQuery: currentQuery,
        status: status,
      );

      final result = await _fetchFromUseCase(params);
      result.fold(
        (l) => state = AsyncData(
          current.copyWith(isLoadingMore: false, error: l.message),
        ),
        (r) {
          final updatedData = BillingSummaryEntity(
            totalCount: r.totalCount,
            planDetails: r.planDetails,
            billingCycles: [...currentList, ...r.billingCycles],
          );
          state = AsyncData(
            current.copyWith(data: updatedData, isLoadingMore: false),
          );
        },
      );
    } catch (e) {
      state = AsyncData(
        current.copyWith(isLoadingMore: false, error: e.toString()),
      );
    }
  }

  Future<void> refresh() async {
    await fetchBillingCycles();
  }

  Future<Either<Failure, void>> downloadBillingSheet(String id) async {
    return ref.read(downloadBillingSheetUseCaseProvider).call(id);
  }

  Future<Either<Failure, void>> sync() async {
    final result = await ref.read(syncBillingCyclesUseCaseProvider).call();
    return result.fold(
      (l) => Left(l),
      (r) async {
        await fetchBillingCycles();
        return const Right(null);
      },
    );
  }
}
