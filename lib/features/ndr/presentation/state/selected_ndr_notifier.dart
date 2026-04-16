import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/ndr/domain/entity/ndr_order_entity.dart';
import 'package:sharkship/features/ndr/domain/entity/ndr_reattempt_params.dart';
import 'package:sharkship/features/ndr/domain/entity/ndr_response_entity.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_notifier.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'dart:io';
part 'selected_ndr_notifier.g.dart';

class SelectedNdrsState {
  final Set<String> selectedIds;
  final bool isLoading;
  final String? message;

  const SelectedNdrsState({
    required this.selectedIds,
    required this.isLoading,
    this.message,
  });

  SelectedNdrsState copyWith({
    Set<String>? selectedIds,
    bool? isLoading,
    String? message,
  }) {
    return SelectedNdrsState(
      isLoading: isLoading ?? this.isLoading,
      selectedIds: selectedIds ?? this.selectedIds,
      message: message ?? this.message,
    );
  }
}

@riverpod
class SelectedNdrNotifier extends _$SelectedNdrNotifier {
  @override
  SelectedNdrsState build(int index) {
    return const SelectedNdrsState(selectedIds: {}, isLoading: false);
  }

  void toggle(String id) {
    final current = state.selectedIds;

    if (current.contains(id)) {
      state = state.copyWith(selectedIds: {...current}..remove(id));
    } else {
      state = state.copyWith(selectedIds: {...current, id});
    }
  }

  void toggleAll(NdrResponseEntity value) {
    final allIds = value.orders.map((e) => e.id.toString()).toSet();

    if (state.selectedIds.length == allIds.length) {
      state = state.copyWith(selectedIds: {});
    } else {
      state = state.copyWith(selectedIds: allIds);
    }
  }

  bool isAllSelected(NdrResponseEntity value) {
    final total = value.orders.length;
    return state.selectedIds.isNotEmpty && state.selectedIds.length == total;
  }

  void clear() {
    state = state.copyWith(selectedIds: {});
  }

  /// Schedules a re-delivery attempt for NDR orders.
  /// If [ids] is null, uses the currently selected orders.
  /// [updatedDeliveryDate] must be in ISO 8601 format: YYYY-MM-DDTHH:mm:ss.sssZ
  /// Returns `true` on success, rethrows on failure.
  Future<bool> reattempt(
    String updatedDeliveryDate, {
    List<String>? ids,
  }) async {
    final targetIds = ids ?? state.selectedIds.toList();
    if (targetIds.isEmpty) return false;

    state = state.copyWith(isLoading: true, message: 'Scheduling reattempt...');
    try {
      final params = NdrReattemptParams(
        orderIds: targetIds,
        updatedDeliveryDate: updatedDeliveryDate,
      );
      await ref.read(reattemptNdrOrdersUseCaseProvider).execute(params);
      
      // Clear selection only if we reattempted the selection
      if (ids == null) {
        state = state.copyWith(selectedIds: {}, isLoading: false, message: null);
      } else {
        state = state.copyWith(isLoading: false, message: null);
      }
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, message: null);
      rethrow;
    }
  }

  Future<void> exportOrders(int tab) async {
    final ndrIds = state.selectedIds;
    print(ndrIds);
    try {
      final ndrOrders = ref.read(ndrProvider(tab)).value?.data?.orders;
      if (ndrOrders == null) return;
      final filteredNdrs = ndrOrders
          .where((e) => ndrIds.contains((e.id.toString())))
          .toList();
      await _saveExportedNdrsToExcel(filteredNdrs);
      print(filteredNdrs);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveExportedNdrsToExcel(List<NdrOrderEntity> ndrs) async {
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
        "Pickup Lane 1",
        "Pickup Lane 2",
        "Pickup City",
        "Pickup State",
        "Pickup Pin",
        "Quantity",
        "Weight",
        "Status",
        "Whatsapp Remark",
        "Zone",
        "Customer Name",
        "Customer Mobile",
        "Customer Email",
        "Customer Address 1",
        "Customer Address 2",
        "Landmark",
        "Customer Pin",
        "Customer City",
        "Customer State",
        "Last Event",
        "Shipping Charge",
        "NDR Reasons",
      ];

      // Set headers in Excel
      sheetObject.appendRow(headers.map((e) => TextCellValue(e)).toList());

      // Add Data Rows
      for (var order in ndrs) {
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
          TextCellValue(order.pickupAddress.addressLane1 ?? ""),
          TextCellValue(order.pickupAddress.addressLane2 ?? ""),
          TextCellValue(order.pickupAddress.city ?? ""),
          TextCellValue(order.pickupAddress.state ?? ""),
          TextCellValue(order.pickupAddress.pin?.toString() ?? ""),
          IntCellValue(order.productQuantity),
          TextCellValue(order.productWeightInKg),
          TextCellValue(order.status),
          TextCellValue(order.whatsappRemark ?? ""),
          TextCellValue(""), // Zone not in entity
          TextCellValue(order.customer.name),
          TextCellValue(order.customer.mobileNo),
          TextCellValue(""), // Email not in CustomerEntity
          TextCellValue(order.deliveryAddress.addressLane1 ?? ""),
          TextCellValue(order.deliveryAddress.addressLane2 ?? ""),
          TextCellValue(order.deliveryAddress.landmark ?? ""),
          TextCellValue(order.deliveryAddress.pin?.toString() ?? ""),
          TextCellValue(order.deliveryAddress.city ?? ""),
          TextCellValue(order.deliveryAddress.state ?? ""),
          TextCellValue(order.lastEventAt?.toIso8601String() ?? ""),
          TextCellValue(order.shippingCharge?.toString() ?? "0"),
          TextCellValue(order.ndrReasons.join(", ")),
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
          '${directory!.path}/NDR_orders_Export_$timestamp.xlsx';

      final List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        print("Exported file saved to: $filePath");
        await OpenFile.open(filePath);
      }
    } catch (e) {
      print("Error saving exported orders to Excel: $e");
    }
  }
}
