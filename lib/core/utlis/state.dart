class AppState<T> {
  final T? data;
  final String? error;
  final bool isLoading;

  AppState({
    this.data,
    this.error,
    this.isLoading = false,
  });

  factory AppState.loading() => AppState(isLoading: true);

  factory AppState.success(T data) => AppState(data: data);

  factory AppState.error(String message) => AppState(error: message);
}
