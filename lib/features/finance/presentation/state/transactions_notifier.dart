import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/message_metrics_entity.dart';
import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';
import 'package:sharkship/features/finance/presentation/state/ts_filters_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/state/ts_tab_provider.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import '../../domain/entities/transaction_entity.dart';
import 'finance_providers.dart';

part 'transactions_notifier.g.dart';

class TransactionsState {
  final TransactionResponse? data;
  final MessageMetricsEntity? messagesMetrics;
  final MessageTransactionsResponse? messageTransactions;
  final bool isLoading;
  final bool isFiltering;
  final bool isLoadingMore;
  final String? error;

  TransactionsState({
    this.data,
    this.messagesMetrics,
    this.messageTransactions,
    this.isLoading = false,
    this.isFiltering = false,
    this.isLoadingMore = false,
    this.error,
  });

  TransactionsState copyWith({
    TransactionResponse? data,
    MessageMetricsEntity? messagesMetrics,
    MessageTransactionsResponse? messageTransactions,
    bool? isLoading,
    bool? isFiltering,
    bool? isLoadingMore,
    String? error,
  }) {
    return TransactionsState(
      data: data ?? this.data,
      messagesMetrics: messagesMetrics ?? this.messagesMetrics,
      messageTransactions: messageTransactions ?? this.messageTransactions,
      isLoading: isLoading ?? this.isLoading,
      isFiltering: isFiltering ?? this.isFiltering,
      error: error ?? this.error,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class TransactionsParams {
  final int total;
  final int skip;
  final String? transactionType;
  final String? affectedBalance;
  final String? transactionCategory;
  final String startDate;
  final String endDate;
  final String isWallet;
  final String? paymentGateway;
  final String? journeyType;
  final bool isFilter;
  final String? orderId;
  final String? trackingId;
  final String? paymentGatewayId;

  TransactionsParams({
    required this.total,
    required this.skip,
    this.transactionCategory,
    this.transactionType,
    this.affectedBalance,
    required this.startDate,
    required this.endDate,
    required this.isWallet,
    this.paymentGateway,
    this.journeyType,
    required this.isFilter,
    this.orderId,
    this.trackingId,
    this.paymentGatewayId,
  });

  TransactionsParams copyWith({
    int? total,
    int? skip,
    String? transactionType,
    String? affectedBalance,
    String? transactionCategory,
    String? startDate,
    String? endDate,
    String? isWallet,
    String? paymentGateway,
    String? journeyType,
    bool? isFilter,
    String? orderId,
    String? trackingId,
    String? paymentGatewayId,
  }) {
    return TransactionsParams(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      transactionType: transactionType ?? this.transactionType,
      affectedBalance: affectedBalance ?? this.affectedBalance,
      transactionCategory: transactionCategory ?? this.transactionCategory,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isWallet: isWallet ?? this.isWallet,
      paymentGateway: paymentGateway ?? this.paymentGateway,
      journeyType: journeyType ?? this.journeyType,
      isFilter: isFilter ?? this.isFilter,
      orderId: orderId ?? this.orderId,
      trackingId: trackingId ?? this.trackingId,
      paymentGatewayId: paymentGatewayId ?? this.paymentGatewayId,
    );
  }
}

@riverpod
class Transactions extends _$Transactions {
  @override
  Future<TransactionsState> build(int tabIndex) async {
    final dashboardDate = ref.watch(dashboardDateProvider);
    final walletType = ref.watch(tsWalletTypeFilterProvider);
    final journeyType = ref.watch(tsJourneyTypeFilterProvider);
    final txnType = ref.watch(tsTxnTypeFilterProvider);

    // Only watch parts of searchState that should trigger a refetch.
    // This avoids rebuilds when changing search type while search is inactive.
    final searchState = ref.watch(tsSearchProvider);
    final effectiveSearch = (searchState.active && searchState.value.isNotEmpty)
        ? (type: searchState.type, value: searchState.value)
        : null;

    if (tabIndex == 0 || tabIndex == 1) {
      String? orderId;
      String? trackingId;
      String? paymentGatewayId;

      if (effectiveSearch != null) {
        if (effectiveSearch.type == SearchType.orderId) {
          orderId = effectiveSearch.value;
        } else if (effectiveSearch.type == SearchType.trackingId) {
          trackingId = effectiveSearch.value;
        } else if (effectiveSearch.type == SearchType.txnId) {
          paymentGatewayId = effectiveSearch.value;
        }
      }

      final params = TransactionsParams(
        total: 10,
        skip: 0,
        startDate: dashboardDate.start.toIso8601String(),
        endDate: dashboardDate.end.toIso8601String(),
        isWallet: getWalletStatus(tabIndex),
        isFilter: false,
        orderId: orderId,
        trackingId: trackingId,
        paymentGatewayId: paymentGatewayId,
        transactionType: txnType == "All" ? null : txnType?.toUpperCase(),
        journeyType: journeyType == "All" ? null : journeyType?.toUpperCase(),
        affectedBalance: walletType == "All" ? null : walletType?.toUpperCase(),
      );

      final response = await _fetchFromUseCase(params, tabIndex);
      return TransactionsState(data: response);
    } else {
      final msgParams = TransactionsParams(
        total: 10,
        skip: 0,
        startDate: dashboardDate.start.toIso8601String(),
        endDate: dashboardDate.end.toIso8601String(),
        isWallet: "sms",
        isFilter: false,
      );

      final msgResult = await ref
          .read(getMessageTransactionsUseCaseProvider)
          .execute(msgParams);

      final metricsResult = await ref
          .read(getMessageMetricsUseCaseProvider)
          .execute(
            startDate: dashboardDate.start.toIso8601String(),
            endDate: dashboardDate.end.toIso8601String(),
          );

      return TransactionsState(
        messagesMetrics: metricsResult,
        messageTransactions: msgResult.fold((l) => null, (r) => r),
        error: msgResult.fold((l) => l.message, (r) => null),
      );
    }
  }

  Future<TransactionResponse> _fetchFromUseCase(
    TransactionsParams params,
    int selectedTab,
  ) async {
    return ref
        .read(getTransactionsUseCaseProvider)
        .execute(
          total: params.total,
          skip: params.skip,
          transactionType: params.transactionType,
          affectedBalance: params.affectedBalance,
          transactionCategory: params.transactionCategory,
          startDate: params.startDate,
          endDate: params.endDate,
          isWallet: params.isWallet,
          paymentGateway: params.paymentGateway,
          journeyType: params.journeyType,
          trackingId: params.trackingId,
          orderId: params.orderId,
          paymentGatewayId: params.paymentGatewayId,
        );
  }

  Future<void> fetchTransactions(
    TransactionsParams params,
    int selectedTab,
  ) async {
    if (params.isFilter) {
      state = AsyncData(
        state.value?.copyWith(isFiltering: true, error: null) ??
            TransactionsState(isFiltering: true),
      );
    } else {
      state = AsyncData(
        state.value?.copyWith(isLoading: true, error: null) ??
            TransactionsState(isLoading: true),
      );
    }

    try {
      final result = await _fetchFromUseCase(params, selectedTab);
      state = AsyncData(
        TransactionsState(data: result, isLoading: false, isFiltering: false),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  String getWalletStatus(int tab) {
    switch (tab) {
      case 0:
        return "ORDER";
      case 1:
        return "PAYMENT";
      case 2:
        return "sms";
      default:
        return "";
    }
  }

  TransactionsParams _buildParams() {
    final dashboardDate = ref.read(dashboardDateProvider);
    final searchState = ref.read(tsSearchProvider);
    final walletType = ref.read(tsWalletTypeFilterProvider);
    final journeyType = ref.read(tsJourneyTypeFilterProvider);
    final txnType = ref.read(tsTxnTypeFilterProvider);

    String? orderId;
    String? trackingId;
    String? paymentGatewayId;
    if (searchState.active && searchState.value.isNotEmpty) {
      if (searchState.type == SearchType.orderId) {
        orderId = searchState.value;
        trackingId = "";
        paymentGatewayId = "";
      } else if (searchState.type == SearchType.trackingId) {
        trackingId = searchState.value;
        orderId = "";
        paymentGatewayId = "";
      } else if (searchState.type == SearchType.txnId) {
        paymentGatewayId = searchState.value;
        orderId = "";
        trackingId = "";
      }
    }

    return TransactionsParams(
      total: 10,
      skip: 0,
      startDate: dashboardDate.start.toIso8601String(),
      endDate: dashboardDate.end.toIso8601String(),
      isWallet: getWalletStatus(tabIndex),
      isFilter: false,
      orderId: orderId,
      trackingId: trackingId,
      paymentGatewayId: paymentGatewayId,
      transactionType: txnType == "All" ? null : txnType?.toUpperCase(),
      journeyType: journeyType == "All" ? null : journeyType?.toUpperCase(),
      affectedBalance: walletType == "All" ? null : walletType?.toUpperCase(),
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore) return;

    if (tabIndex == 0 || tabIndex == 1) {
      if (current.data == null) return;
      final totalCount = current.data!.totalCount;
      final currentList = current.data!.transactions;

      if (currentList.length >= totalCount) return;

      state = AsyncData(current.copyWith(isLoadingMore: true));

      try {
        final params = _buildParams().copyWith(
          skip: currentList.length,
          total: 10,
        );
        final newResponse = await _fetchFromUseCase(params, tabIndex);

        final updatedData = TransactionResponse(
          totalCount: newResponse.totalCount,
          transactions: [...currentList, ...newResponse.transactions],
        );

        state = AsyncData(
          current.copyWith(data: updatedData, isLoadingMore: false),
        );
      } catch (e, st) {
        state = AsyncData(
          current.copyWith(isLoadingMore: false, error: e.toString()),
        );
      }
    } else {
      if (current.messageTransactions == null) return;
      final totalCount = current.messageTransactions!.totalCount;
      final currentList = current.messageTransactions!.transactions;

      if (currentList.length >= totalCount) return;

      state = AsyncData(current.copyWith(isLoadingMore: true));

      try {
        final dashboardDate = ref.read(dashboardDateProvider);
        final msgParams = TransactionsParams(
          total: 10,
          skip: currentList.length,
          startDate: dashboardDate.start.toIso8601String(),
          endDate: dashboardDate.end.toIso8601String(),
          isWallet: "sms",
          isFilter: false,
        );

        final result = await ref
            .read(getMessageTransactionsUseCaseProvider)
            .execute(msgParams);

        result.fold(
          (l) => state = AsyncData(
            current.copyWith(isLoadingMore: false, error: l.message),
          ),
          (r) {
            final updatedResponse = MessageTransactionsResponse(
              totalCount: r.totalCount,
              transactions: [...currentList, ...r.transactions],
            );

            state = AsyncData(
              current.copyWith(
                messageTransactions: updatedResponse,
                isLoadingMore: false,
              ),
            );
          },
        );
      } catch (e, st) {
        state = AsyncData(
          current.copyWith(isLoadingMore: false, error: e.toString()),
        );
      }
    }
  }
}
