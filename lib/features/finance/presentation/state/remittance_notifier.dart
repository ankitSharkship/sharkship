import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';
import 'package:sharkship/features/finance/presentation/state/rs_filters_tab_provider.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'finance_providers.dart';

part 'remittance_notifier.g.dart';

class RemittanceState {
  final RemittanceDetails? details;
  final List<RemittanceCycle> cycles;
  final int totalCount;
  final bool isLoading;
  final bool isFiltering;
  final bool isLoadingMore;
  final String? error;

  RemittanceState({
    this.details,
    this.cycles = const [],
    this.totalCount = 0,
    this.isLoading = false,
    this.isFiltering = false,
    this.isLoadingMore = false,
    this.error,
  });

  RemittanceState copyWith({
    RemittanceDetails? details,
    List<RemittanceCycle>? cycles,
    int? totalCount,
    bool? isLoading,
    bool? isFiltering,
    bool? isLoadingMore,
    String? error,
  }) {
    return RemittanceState(
      details: details ?? this.details,
      cycles: cycles ?? this.cycles,
      totalCount: totalCount ?? this.totalCount,
      isLoading: isLoading ?? this.isLoading,
      isFiltering: isFiltering ?? this.isFiltering,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }
}

class RemittanceCycleParams {
  final int total;
  final int skip;
  final String startDate;
  final String endDate;
  final String? status;
  final String? businessName;
  final String? remittanceId;
  final String? userId;
  final String? phone;

  RemittanceCycleParams({
    required this.total,
    required this.skip,
    required this.startDate,
    required this.endDate,
    this.status,
    this.businessName,
    this.remittanceId,
    this.userId,
    this.phone,
  });

  RemittanceCycleParams copyWith({
    int? total,
    int? skip,
    String? startDate,
    String? endDate,
    String? status,
    String? businessName,
    String? remittanceId,
    String? userId,
    String? phone,
  }) {
    return RemittanceCycleParams(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      businessName: businessName ?? this.businessName,
      remittanceId: remittanceId ?? this.remittanceId,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
    );
  }
}

@riverpod
class Remittance extends _$Remittance {
  @override
  Future<RemittanceState> build() async {
    final dateRange = ref.watch(dashboardDateProvider);
    final detailsResult = await ref
        .read(getRemittanceDetailsUseCaseProvider)
        .call();

    final params = RemittanceCycleParams(
      total: 10,
      skip: 0,
      startDate: dateRange.start.toIso8601String(),
      endDate: dateRange.end.toIso8601String(),
      status: ref.read(rsStatusTypeFilterProvider),
    );
    final cyclesResult = await ref
        .read(getRemittanceCyclesUseCaseProvider)
        .call(params);

    return RemittanceState(
      details: detailsResult.fold((l) => null, (r) => r),
      cycles: cyclesResult.map((r) => r.remittanceCycles).getOrElse(() => []),
      totalCount: cyclesResult.map((r) => r.totalCount).getOrElse(() => 0),
      isLoading: false,
    );
  }

  Future<void> fetchAll() async {
    final current = state.value ?? RemittanceState();
    state = AsyncData(current.copyWith(isLoading: true, error: null));

    await Future.wait([fetchDetails(), fetchCycles(_buildParams())]);

    final updated = state.value ?? current;
    state = AsyncData(updated.copyWith(isLoading: false));
  }

  Future<void> fetchDetails() async {
    final result = await ref.read(getRemittanceDetailsUseCaseProvider).call();
    final current = state.value ?? RemittanceState();

    result.fold(
      (l) => state = AsyncData(current.copyWith(error: l.message)),
      (r) => state = AsyncData(current.copyWith(details: r)),
    );
  }

  RemittanceCycleParams _buildParams() {
    final dateRange = ref.read(dashboardDateProvider);
    return RemittanceCycleParams(
      total: 10,
      skip: 0,
      startDate: dateRange.start.toIso8601String(),
      endDate: dateRange.end.toIso8601String(),
      status: ref.read(rsStatusTypeFilterProvider),
    );
  }

  Future<void> fetchCycles(RemittanceCycleParams params) async {
    final result = await ref
        .read(getRemittanceCyclesUseCaseProvider)
        .call(params);
    final current = state.value ?? RemittanceState();

    result.fold(
      (l) => state = AsyncData(
        current.copyWith(error: l.message, isFiltering: false),
      ),
      (r) {
        state = AsyncData(
          current.copyWith(
            cycles: r.remittanceCycles,
            totalCount: r.totalCount,
            isFiltering: false,
          ),
        );
      },
    );
  }

  Future<void> applyFilters() async {
    final current = state.value ?? RemittanceState();
    state = AsyncData(
      current.copyWith(isFiltering: true, cycles: [], totalCount: 0),
    );
    await fetchCycles(_buildParams());
  }

  Future<void> loadMore() async {
    final current = state.value ?? RemittanceState();
    if (current.isLoadingMore || current.cycles.length >= current.totalCount)
      return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    final params = _buildParams().copyWith(skip: current.cycles.length);
    final result = await ref
        .read(getRemittanceCyclesUseCaseProvider)
        .call(params);

    result.fold(
      (l) => state = AsyncData(
        current.copyWith(error: l.message, isLoadingMore: false),
      ),
      (r) {
        state = AsyncData(
          current.copyWith(
            cycles: [...current.cycles, ...r.remittanceCycles],
            totalCount: r.totalCount,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
