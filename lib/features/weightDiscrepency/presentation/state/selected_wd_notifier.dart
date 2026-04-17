import 'dart:io';

import 'package:excel/excel.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/weightDiscrepency/domain/entities/wd_response_entity.dart';
import 'package:sharkship/features/weightDiscrepency/domain/entities/weight_discrepancy_entity.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_notifier.dart';

part 'selected_wd_notifier.g.dart';

class SelectedWdsState {
  final Set<String> selectedIds;
  final bool isLoading;
  final String? message;

  const SelectedWdsState({
    required this.selectedIds,
    required this.isLoading,
    this.message,
  });

  SelectedWdsState copyWith({
    Set<String>? selectedIds,
    bool? isLoading,
    String? message,
  }) {
    return SelectedWdsState(
      isLoading: isLoading ?? this.isLoading,
      selectedIds: selectedIds ?? this.selectedIds,
      message: message ?? this.message,
    );
  }
}

@riverpod
class SelectedWdNotifier extends _$SelectedWdNotifier {
  @override
  SelectedWdsState build(int index) {
    return const SelectedWdsState(selectedIds: {}, isLoading: false);
  }

  void toggle(String id) {
    final current = state.selectedIds;

    if (current.contains(id)) {
      state = state.copyWith(selectedIds: {...current}..remove(id));
    } else {
      state = state.copyWith(selectedIds: {...current, id});
    }
  }

  void toggleAll(WdResponseEntity value) {
    final allIds = value.items.map((e) => e.id.toString()).toSet();

    if (state.selectedIds.length == allIds.length) {
      state = state.copyWith(selectedIds: {});
    } else {
      state = state.copyWith(selectedIds: allIds);
    }
  }

  bool isAllSelected(WdResponseEntity value) {
    final total = value.items.length;
    return state.selectedIds.isNotEmpty && state.selectedIds.length == total;
  }

  void clear() {
    state = state.copyWith(selectedIds: {});
  }

  Future<void> exportOrders(int tab) async {
    final wdIds = state.selectedIds;
    try {
      final wdOrders = ref.read(wdProvider(tab)).value?.data?.items;
      if (wdOrders == null) return;
      
      final filteredWds = wdOrders
          .where((e) => wdIds.contains((e.id.toString())))
          .toList();
          
      if (filteredWds.isEmpty) return;
      
      await _saveExportedWdsToExcel(filteredWds);
    } catch (e) {
      print("Export error: $e");
    }
  }

  Future<void> _saveExportedWdsToExcel(List<WeightDiscrepancyEntity> wds) async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Sheet1'];

      List<String> headers = [
        "ID",
        "Client Order ID",
        "Channel Order ID",
        "Channel Store",
        "Tracking ID",
        "Creation Date",
        "Carrier",
        "Courier Type",
        "Channel",
        "Payment Type",
        "Price",
        "Total Price",
        "Product Name",
        "Category",
        "Pickup City",
        "Pickup State",
        "Pickup Pin",
        "Quantity",
        "Weight",
        "Status",
        "Customer Name",
        "Customer Mobile",
        "Customer Address",
        "Last Event",
        "Dispute Status",
        "Original Weight",
        "Disputed Weight",
      ];

      // Set headers in Excel
      sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

      // Add Data Rows
      for (var order in wds) {
        sheetObject.appendRow([
          TextCellValue(order.id.toString()),
          TextCellValue(order.clientOrderId ?? ""),
          TextCellValue(order.channelOrderId ?? ""),
          TextCellValue(order.channelStore ?? ""),
          TextCellValue(order.trackingId ?? ""),
          TextCellValue(order.createdAt.toIso8601String()),
          TextCellValue(order.carrier ?? ""),
          TextCellValue(order.courierType ?? ""),
          TextCellValue(order.channel),
          TextCellValue(order.paymentMode),
          DoubleCellValue(order.productPrice.toDouble()),
          DoubleCellValue(order.codAmount.toDouble()),
          TextCellValue(order.productName),
          TextCellValue(order.productSkuNo ?? ""),
          TextCellValue(order.pickupAddress.city ?? ""),
          TextCellValue(order.pickupAddress.state ?? ""),
          TextCellValue(order.pickupAddress.pin?.toString() ?? ""),
          IntCellValue(order.productQuantity),
          TextCellValue(order.productWeightInKg),
          TextCellValue(order.status),
          TextCellValue(order.customer.name ?? ""),
          TextCellValue(order.customer.mobileNo ?? ""),
          TextCellValue("${order.deliveryAddress.addressLane1 ?? ""} ${order.deliveryAddress.addressLane2 ?? ""}"),
          TextCellValue(order.lastEventAt?.toIso8601String() ?? ""),
          TextCellValue(order.weightDispute?.status ?? "N/A"),
          TextCellValue(order.productWeightInKg),
          TextCellValue(order.weightDispute?.changeWeight ?? "N/A"),
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

      final String timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final String filePath = '${directory!.path}/WD_Export_$timestamp.xlsx';

      final List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        await OpenFile.open(filePath);
      }
    } catch (e) {
      print("Error saving exported orders to Excel: $e");
    }
  }
}
