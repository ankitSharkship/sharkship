import 'dart:io';

class BulkOrdersState {
  final File? file;
  final bool isLoading;
  BulkOrdersState({this.file, this.isLoading = false});

  BulkOrdersState copyWith({File? file, bool? isLoading, bool clearFile = false}) {
    return BulkOrdersState(
      file: clearFile ? null : (file ?? this.file),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
