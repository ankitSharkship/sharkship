import 'dart:io';

class BulkOrdersState {
  final File? file;
  final bool isLoading;
  final bool isDownloading;
  BulkOrdersState({this.file, this.isLoading = false, this.isDownloading = false});

  BulkOrdersState copyWith({
    File? file,
    bool? isLoading,
    bool clearFile = false,
    bool? isDownloading
  }) {
    return BulkOrdersState(
      file: clearFile ? null : (file ?? this.file),
      isLoading: isLoading ?? this.isLoading,
      isDownloading: isDownloading ?? this.isDownloading
    );
  }
}
