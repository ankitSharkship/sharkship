import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'package:sharkship/features/orders/presentation/state/bulk_orders_state.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

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

  Future<void> downloadTemplate(BuildContext context) async {
    state = state.copyWith(isDownloading: true);
    try {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20, // Set smaller width
                  height: 20, // Set smaller height
                  child: CircularProgressIndicator(
                    color: AppColors.primaryBlue,
                    strokeWidth: 2, // Thinner stroke for smaller size
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Downloading template...',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
              ],
            ),
            backgroundColor: AppColors.lightBlueBg,
          ),
        );
      }

      await ref.read(downloadTemplateUsecaseProvider).execute();

      state = state.copyWith(isDownloading: false);
    } catch (e) {
      // Handle error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to download template"),
            backgroundColor: Colors.red,
          ),
        );
      }
      state = state.copyWith(isDownloading: false);
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
