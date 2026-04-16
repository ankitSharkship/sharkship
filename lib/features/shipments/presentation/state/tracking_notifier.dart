import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/tracking_details_entity.dart';
import 'tracking_providers.dart';

part 'tracking_notifier.g.dart';

@riverpod
class TrackingNotifier extends _$TrackingNotifier {
  @override
  FutureOr<TrackingDetailsEntity?> build() {
    return null; 
  }

  Future<void> fetchTrackingDetails(String trackingId) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      return await ref
          .read(getTrackingDetailsUseCaseProvider)
          .execute(trackingId);
    });
    if (ref.mounted) {
      state = result;
    }
  }
}
