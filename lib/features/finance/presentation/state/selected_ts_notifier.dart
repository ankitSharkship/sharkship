import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';
import 'dart:io';

import 'package:sharkship/features/finance/domain/entities/transaction_entity.dart';
import 'package:sharkship/features/finance/presentation/state/transactions_notifier.dart';
part 'selected_ts_notifier.g.dart';

class SelectedTssState {
  final Set<String> selectedIds;
  final bool isLoading;
  final String? message;

  const SelectedTssState({
    required this.selectedIds,
    required this.isLoading,
    this.message,
  });

  SelectedTssState copyWith({
    Set<String>? selectedIds,
    bool? isLoading,
    String? message,
  }) {
    return SelectedTssState(
      isLoading: isLoading ?? this.isLoading,
      selectedIds: selectedIds ?? this.selectedIds,
      message: message ?? this.message,
    );
  }
}

@riverpod
class SelectedTsNotifier extends _$SelectedTsNotifier {
  @override
  SelectedTssState build(int index) {
    return const SelectedTssState(selectedIds: {}, isLoading: false);
  }

  void toggle(String id) {
    final current = state.selectedIds;

    if (current.contains(id)) {
      state = state.copyWith(selectedIds: {...current}..remove(id));
    } else {
      state = state.copyWith(selectedIds: {...current, id});
    }
  }

  void toggleAll(int selectedTab) {
    if (selectedTab == 0 || selectedTab == 1) {
      final value = ref
          .read(transactionsProvider(selectedTab))
          .asData
          ?.value
          .data;
      final allIds = value?.transactions.map((e) => e.id.toString()).toSet();

      if (state.selectedIds.length == allIds?.length) {
        state = state.copyWith(selectedIds: {});
      } else {
        state = state.copyWith(selectedIds: allIds);
      }
    } else {
      final value = ref
          .read(transactionsProvider(selectedTab))
          .asData
          ?.value
          .messageTransactions;
      final allIds = value?.transactions.map((e) => e.id.toString()).toSet();

      if (state.selectedIds.length == allIds?.length) {
        state = state.copyWith(selectedIds: {});
      } else {
        state = state.copyWith(selectedIds: allIds);
      }
    }
  }

  bool isAllSelected(int selectedTab) {
    if (selectedTab == 0 || selectedTab == 1) {
      final currValue = ref
          .read(transactionsProvider(selectedTab))
          .asData
          ?.value
          .data;
      final total = currValue?.transactions.length;
      return state.selectedIds.isNotEmpty && state.selectedIds.length == total;
    } else {
      final currValue = ref
          .read(transactionsProvider(selectedTab))
          .asData
          ?.value
          .messageTransactions;
      final total = currValue?.transactions.length;
      return state.selectedIds.isNotEmpty && state.selectedIds.length == total;
    }

  }

  void clear() {
    state = state.copyWith(selectedIds: {});
  }

  Future<void> exportOrders(int tab) async {
    final tsIds = state.selectedIds;
    if (tsIds.isEmpty) return;

    state = state.copyWith(
      isLoading: true,
      message: 'Exporting transactions...',
    );
    try {
      final transactions = ref
          .read(transactionsProvider(tab))
          .value
          ?.data
          ?.transactions;
      if (transactions == null) return;

      final filteredTss = transactions
          .where((e) => tsIds.contains(e.id))
          .toList();

      await _saveExportedTssToExcel(filteredTss);
      state = state.copyWith(isLoading: false, message: null, selectedIds: {});
    } catch (e) {
      state = state.copyWith(isLoading: false, message: null, selectedIds: {});
      rethrow;
    }
  }

  Future<void> _saveExportedTssToExcel(
    List<TransactionEntity> transactions,
  ) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        "ID",
        "Date",
        "Description",
        "Journey Type",
        "Affected",
        "Type",
        "Amount",
        "Order ID",
        "Tracking ID",
        "Remarks",
      ];

      // Set headers in Excel
      sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

      // Add Data Rows
      for (var ts in transactions) {
        sheetObject.appendRow([
          TextCellValue(ts.id),
          TextCellValue(ts.createdAt.toIso8601String()),
          TextCellValue(ts.description),
          TextCellValue(ts.journeyType ?? ""),
          TextCellValue(ts.affected),
          TextCellValue(ts.type),
          TextCellValue(ts.amount),
          TextCellValue(ts.orderId ?? ""),
          TextCellValue(ts.trackingId ?? ""),
          TextCellValue(ts.remarks ?? ""),
        ]);
      }

      // Save File
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      final String timestamp = DateTime.now().toIso8601String().replaceAll(
        ':',
        '-',
      );
      final String filePath =
          '${directory!.path}/Transactions_Export_$timestamp.xlsx';

      final List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        await OpenFile.open(filePath);
      }
    } catch (e) {
      rethrow;
    }
  }
}
