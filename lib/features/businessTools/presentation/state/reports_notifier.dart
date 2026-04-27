import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/businessTools/domain/usecases/request_mis_report_usecase.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'business_tools_providers.dart';

part 'reports_notifier.g.dart';

class ReportsState {
  final List<String> partners;
  final List<String> selectedStatuses;
  final List<String> selectedPartners;
  final DateTime? startDate;
  final DateTime? endDate;

  ReportsState({
    required this.partners,
    required this.selectedStatuses,
    required this.selectedPartners,
    this.startDate,
    this.endDate,
  });

  ReportsState copyWith({
    List<String>? partners,
    List<String>? selectedStatuses,
    List<String>? selectedPartners,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return ReportsState(
      partners: partners ?? this.partners,
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
      selectedPartners: selectedPartners ?? this.selectedPartners,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

@riverpod
class ReportsNotifier extends _$ReportsNotifier {
  @override
  FutureOr<ReportsState> build() async {
    final courierPartners =
        await ref.read(getCourierPartnersUseCaseProvider).execute();

    // Filter unique partner names
    final uniquePartnerNames =
        courierPartners.map((p) => p.carrier).toSet().toList();
    uniquePartnerNames.sort();

    return ReportsState(
      partners: uniquePartnerNames,
      selectedStatuses: ['All Status'],
      selectedPartners: ['All Carriers'],
    );
  }

  void setStartDate(DateTime date) {
    state = AsyncValue.data(state.value!.copyWith(startDate: date));
  }

  void setEndDate(DateTime date) {
    state = AsyncValue.data(state.value!.copyWith(endDate: date));
  }

  void toggleStatus(String status) {
    if (state.value == null) return;
    final current = List<String>.from(state.value!.selectedStatuses);

    if (status == 'All Status') {
      current.clear();
      current.add('All Status');
    } else {
      current.remove('All Status');
      if (current.contains(status)) {
        current.remove(status);
        if (current.isEmpty) current.add('All Status');
      } else {
        current.add(status);
      }
    }
    state = AsyncValue.data(state.value!.copyWith(selectedStatuses: current));
  }

  void togglePartner(String partner) {
    if (state.value == null) return;
    final current = List<String>.from(state.value!.selectedPartners);

    if (partner == 'All Carriers') {
      current.clear();
      current.add('All Carriers');
    } else {
      current.remove('All Carriers');
      if (current.contains(partner)) {
        current.remove(partner);
        if (current.isEmpty) current.add('All Carriers');
      } else {
        current.add(partner);
      }
    }
    state = AsyncValue.data(state.value!.copyWith(selectedPartners: current));
  }

  Future<void> requestReport() async {
    final value = state.value;
    if (value == null) return;

    if (value.startDate == null || value.endDate == null) return;

    state = const AsyncLoading();

    // Map UI statuses to API statuses
    // Example: 'To Be Processed' -> 'TO_BE_PROCESSED'
    final apiStatuses = value.selectedStatuses.contains('All Status')
        ? <String>[] // Backend might handle empty list as all, or we send all options
        : value.selectedStatuses
            .map((s) => s.toUpperCase().replaceAll(' ', '_'))
            .toList();

    final apiCarriers = value.selectedPartners.contains('All Carriers')
        ? <String>[]
        : value.selectedPartners;

    final useCase = ref.read(requestMisReportUseCaseProvider);
    final result = await useCase.execute(
      startDate: value.startDate!.toIso8601String(),
      endDate: value.endDate!.toIso8601String(),
      statuses: apiStatuses,
      carriers: apiCarriers,
    );

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) {
        state = AsyncValue.data(value);
      },
    );
  }
}
