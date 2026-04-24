import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/finance/domain/entities/cn_invoice_entity.dart';
import 'package:sharkship/features/finance/domain/entities/tax_invoice_entity.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'finance_providers.dart';

part 'invoices_summary_notifier.g.dart';

class IsState {
  final List<TaxInvoiceEntity>? taxInvoices;
  final List<CnInvoiceEntity>? cnInvoices;
  final int totalCount;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final String? verificationId;
  final String? downloadError;

  IsState({
    this.taxInvoices,
    this.cnInvoices,
    this.totalCount = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.verificationId,
    this.downloadError,
  });

  IsState copyWith({
    List<TaxInvoiceEntity>? taxInvoices,
    List<CnInvoiceEntity>? cnInvoices,
    int? totalCount,
    bool? isLoading,
    bool? isFiltering,
    bool? isLoadingMore,
    String? error,
    String? verificationId,
    String? downloadError,
  }) {
    return IsState(
      taxInvoices: taxInvoices ?? this.taxInvoices,
      cnInvoices: cnInvoices ?? this.cnInvoices,
      totalCount: totalCount ?? this.totalCount,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      verificationId: verificationId ?? this.verificationId,
      downloadError: downloadError ?? this.downloadError,
    );
  }
}

class TaxInvoiceParams {
  final int total;
  final int skip;
  final String startDate;
  final String endDate;

  TaxInvoiceParams({
    required this.total,
    required this.skip,
    required this.startDate,
    required this.endDate,
  });

  TaxInvoiceParams copyWith({
    int? total,
    int? skip,
    String? startDate,
    String? endDate,
  }) {
    return TaxInvoiceParams(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

class CnInvoiceParams {
  final int total;
  final int skip;
  final String cnStartDate;
  final String cnEndDate;

  CnInvoiceParams({
    required this.total,
    required this.skip,
    required this.cnStartDate,
    required this.cnEndDate,
  });

  CnInvoiceParams copyWith({
    int? total,
    int? skip,
    String? cnStartDate,
    String? cnEndDate,
  }) {
    return CnInvoiceParams(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      cnStartDate: cnStartDate ?? this.cnStartDate,
      cnEndDate: cnEndDate ?? this.cnEndDate,
    );
  }
}

@riverpod
class TaxInvoices extends _$TaxInvoices {
  @override
  Future<IsState> build(int tabIndex) async {
    final dateRange = ref.watch(dashboardDateProvider);

    if (tabIndex == 0) {
      final params = TaxInvoiceParams(
        total: 10,
        skip: 0,
        startDate: dateRange.start.toIso8601String(),
        endDate: dateRange.end.toIso8601String(),
      );
      final result = await ref.read(getTaxInvoicesUseCaseProvider).call(params);

      return IsState(
        taxInvoices: result.map((r) => r.invoices).getOrElse(() => []),
        totalCount: result.map((r) => r.totalCount).getOrElse(() => 0),
        isLoading: false,
      );
    } else {
      final params = CnInvoiceParams(
        total: 10,
        skip: 0,
        cnStartDate: dateRange.start.toIso8601String(),
        cnEndDate: dateRange.end.toIso8601String(),
      );

      final result = await ref
          .read(getCnInvoicesUseCaseProvider)
          .call(
            total: params.total,
            skip: params.skip,
            cnStartDate: params.cnStartDate,
            cnEndDate: params.cnEndDate,
          );

      return IsState(
        cnInvoices: result.map((r) => r.invoices).getOrElse(() => []),
        totalCount: result.map((r) => r.totalCount).getOrElse(() => 0),
        isLoading: false,
      );
    }
  }

  Future<void> fetchAll() async {
    final current = state.value ?? IsState();
    state = AsyncData(current.copyWith(isLoading: true, error: null));

    if (tabIndex == 0) {
      await fetchTaxInvoices(_buildTaxParams());
    } else {
      await fetchCnInvoices(_buildCnParams());
    }

    final updated = state.value ?? current;
    state = AsyncData(updated.copyWith(isLoading: false));
  }

  TaxInvoiceParams _buildTaxParams() {
    final dateRange = ref.read(dashboardDateProvider);
    return TaxInvoiceParams(
      total: 10,
      skip: 0,
      startDate: dateRange.start.toIso8601String(),
      endDate: dateRange.end.toIso8601String(),
    );
  }

  CnInvoiceParams _buildCnParams() {
    final dateRange = ref.read(dashboardDateProvider);
    return CnInvoiceParams(
      total: 10,
      skip: 0,
      cnStartDate: dateRange.start.toIso8601String(),
      cnEndDate: dateRange.end.toIso8601String(),
    );
  }

  Future<void> fetchTaxInvoices(TaxInvoiceParams params) async {
    final result = await ref.read(getTaxInvoicesUseCaseProvider).call(params);
    final current = state.value ?? IsState();

    result.fold((l) => state = AsyncData(current.copyWith(error: l.message)), (
      r,
    ) {
      state = AsyncData(
        current.copyWith(taxInvoices: r.invoices, totalCount: r.totalCount),
      );
    });
  }

  Future<void> fetchCnInvoices(CnInvoiceParams params) async {
    final result = await ref
        .read(getCnInvoicesUseCaseProvider)
        .call(
          total: params.total,
          skip: params.skip,
          cnStartDate: params.cnStartDate,
          cnEndDate: params.cnEndDate,
        );
    final current = state.value ?? IsState();

    result.fold((l) => state = AsyncData(current.copyWith(error: l.message)), (
      r,
    ) {
      state = AsyncData(
        current.copyWith(cnInvoices: r.invoices, totalCount: r.totalCount),
      );
    });
  }

  Future<void> loadMore() async {
    final current = state.value ?? IsState();
    if (current.isLoadingMore) return;

    if (tabIndex == 0) {
      final currentList = current.taxInvoices ?? [];
      if (currentList.length >= current.totalCount) return;

      state = AsyncData(current.copyWith(isLoadingMore: true));
      final params = _buildTaxParams().copyWith(skip: currentList.length);
      final result = await ref.read(getTaxInvoicesUseCaseProvider).call(params);

      result.fold(
        (l) => state = AsyncData(
          current.copyWith(error: l.message, isLoadingMore: false),
        ),
        (r) {
          state = AsyncData(
            current.copyWith(
              taxInvoices: [...currentList, ...r.invoices],
              totalCount: r.totalCount,
              isLoadingMore: false,
            ),
          );
        },
      );
    } else {
      final currentList = current.cnInvoices ?? [];
      if (currentList.length >= current.totalCount) return;

      state = AsyncData(current.copyWith(isLoadingMore: true));
      final params = _buildCnParams().copyWith(skip: currentList.length);
      final result = await ref
          .read(getCnInvoicesUseCaseProvider)
          .call(
            total: params.total,
            skip: params.skip,
            cnStartDate: params.cnStartDate,
            cnEndDate: params.cnEndDate,
          );

      result.fold(
        (l) => state = AsyncData(
          current.copyWith(error: l.message, isLoadingMore: false),
        ),
        (r) {
          state = AsyncData(
            current.copyWith(
              cnInvoices: [...currentList, ...r.invoices],
              totalCount: r.totalCount,
              isLoadingMore: false,
            ),
          );
        },
      );
    }
  }

  Future<bool> initiateOTP(int tab) async {
    final response = await ref.read(initiateInvoiceUseCaseProvider).call();
    final current = state.value ?? IsState();
    state = AsyncData(current.copyWith());
    final result = response.fold(
      (l) {
        state = AsyncData(current.copyWith(downloadError: l.message));
        return false;
      },
      (r) {
        state = AsyncData(current.copyWith(verificationId: r.verifyId));
        return true;
      },
    );
    return result;
  }

  Future<bool> verifySingle(
    bool isPdf,
    String invoiceId,
    bool isTax,
    String otp,
  ) async {
    final current = state.value ?? IsState();
    if (current.verificationId == null) return false;

    final data = {
      "verifyId": current.verificationId,
      "otp": otp,
      "invoiceId": invoiceId,
      "invoiceType": isTax ? "tax" : "cn",
      "fileType": isPdf ? "pdf" : "excel",
    };

    final result = await ref.read(verifySingleUseCaseProvider).call(data);

    final value = result.fold(
      (l) {
        state = AsyncData(current.copyWith(downloadError: l.message));
        return false;
      },
      (r) {
        state = AsyncData(current.copyWith(downloadError: null));
        return true;
      },
    );
    return value;
  }

  Future<bool> verifyBulk(
    bool isPdf,
    Set<String> invoiceIds,
    bool isTax,
    String otp,
  ) async {
    final current = state.value ?? IsState();
    if (current.verificationId == null) return false;

    final fileType = isPdf ? "pdf" : "excel";
    final data = {
      "verifyId": current.verificationId,
      "otp": otp,
      "files": {
        isTax ? "taxInvoices" : "cnInvoices": {fileType: invoiceIds.toList()},
      },
    };

    final result = await ref.read(verifyBulkUseCaseProvider).call(data);

    final value = result.fold(
      (l) {
        state = AsyncData(current.copyWith(downloadError: l.message));

        return false;
      },
      (r) {
        state = AsyncData(current.copyWith(downloadError: null));
        return true;
      },
    );
    return value;
  }
}
