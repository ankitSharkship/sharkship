import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';

import 'dart:io';

import 'package:sharkship/features/finance/presentation/state/remittance_notifier.dart';
part 'selected_rs_notifier.g.dart';

class SelectedRssState {
  final Set<String> selectedIds;
  final bool isLoading;
  final String? message;

  const SelectedRssState({
    required this.selectedIds,
    required this.isLoading,
    this.message,
  });

  SelectedRssState copyWith({
    Set<String>? selectedIds,
    bool? isLoading,
    String? message,
  }) {
    return SelectedRssState(
      isLoading: isLoading ?? this.isLoading,
      selectedIds: selectedIds ?? this.selectedIds,
      message: message ?? this.message,
    );
  }
}

@riverpod
class SelectedRsNotifier extends _$SelectedRsNotifier {
  @override
  SelectedRssState build() {
    return const SelectedRssState(selectedIds: {}, isLoading: false);
  }

  void toggle(String id) {
    final current = state.selectedIds;

    if (current.contains(id)) {
      state = state.copyWith(selectedIds: {...current}..remove(id));
    } else {
      state = state.copyWith(selectedIds: {...current, id});
    }
  }

  void toggleAll() {
    final value = ref.read(remittanceProvider).value?.cycles ?? [];
    final allIds = value.map((e) => e.id.toString()).toSet();

    if (state.selectedIds.length == allIds.length) {
      state = state.copyWith(selectedIds: {});
    } else {
      state = state.copyWith(selectedIds: allIds);
    }
  }

  bool isAllSelected() {
    final currValue = ref.read(remittanceProvider).value?.cycles ?? [];
    final total = currValue.length;
    return state.selectedIds.isNotEmpty && state.selectedIds.length == total;
  }

  void clear() {
    state = state.copyWith(selectedIds: {});
  }

  Future<void> exportOrders() async {
    final tsIds = state.selectedIds;
    if (tsIds.isEmpty) return;

    state = state.copyWith(
      isLoading: true,
      message: 'Exporting transactions...',
    );
    try {
      final transactions = ref.read(remittanceProvider).asData?.value.cycles;
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
    List<RemittanceCycle> remittances,
  ) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        "Cycle Name",
        "Start Delivery Date",
        "End Delivery Date",
        "Start Shipping Date",
        "End Shipping Date",
        "Remittance Date",
        "Cod Collected",
        "Deduction",
        "Remittance Amount",
        "Early Remittance Fee",
        "Fulfillment Reference",
        "Fulfillment Date",
        "Status",
      ];

      // Set headers in Excel
      sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

      // Add Data Rows
      for (var rs in remittances) {
        sheetObject.appendRow([
          TextCellValue(rs.cycleName),
          TextCellValue(rs.startDeliveryDate.toIso8601String()),
          TextCellValue(rs.endDeliveryDate.toIso8601String()),
          TextCellValue(rs.startShippingDate.toIso8601String()),
          TextCellValue(rs.endShippingDate.toIso8601String()),
          TextCellValue(rs.remittanceDate.toIso8601String()),
          TextCellValue(rs.codCollected.toString()),
          TextCellValue(rs.carryforwardAmount.toString()),
          TextCellValue(rs.payableAmount.toString()),
          TextCellValue(rs.earlyRemittanceFee.toString()),
          TextCellValue(rs.fulfillmentReference.toString()),
          TextCellValue(rs.fulfillmentDate?.toIso8601String() ?? ""),
          TextCellValue(rs.status ?? ""),
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
