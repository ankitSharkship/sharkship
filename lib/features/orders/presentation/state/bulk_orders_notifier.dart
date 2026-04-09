import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/state/bulk_orders_state.dart';

part 'bulk_orders_notifier.g.dart';

@riverpod
class BulkOrdersNotifier extends _$BulkOrdersNotifier {
  @override
  BulkOrdersState build() {
    return BulkOrdersState();
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
    );

    if (result != null && result.files.single.path != null) {
      state = state.copyWith(file: File(result.files.single.path!));
    }
  }

  Future<void> downloadTemplate() async {
    state = state.copyWith(isLoading: true);
    try {
      print('Tried and tested');
      await ref.read(downloadTemplateUsecaseProvider).execute();
    } catch (e) {
      // Handle error
      print('Failed hehehehhehehhe');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> submit() async {
    if (state.file == null) return false;
    state = state.copyWith(isLoading: true);
    try {
      final result = await ref
          .read(bulkUploadUsecaseProvider)
          .execute(state.file!);
      state = state.copyWith(isLoading: false, file: null);
      return result;
    } catch (e) {
      state = state.copyWith(isLoading: false, file: null);
      return false;
    }
  }

  void clearFile() {
    state = state.copyWith(clearFile: true);
  }
}
