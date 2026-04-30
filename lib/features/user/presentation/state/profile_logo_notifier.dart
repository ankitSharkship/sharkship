import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'user_notifier.dart';
import 'user_providers.dart';

part 'profile_logo_notifier.g.dart';

@riverpod
class ProfileLogoNotifier extends _$ProfileLogoNotifier {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image == null) return;

    state = const AsyncValue.loading();

    try {
      await ref.read(uploadLogoUseCaseProvider).call(image.path);
      // Refresh user details to show new logo in the UI
      await ref.read(userProvider.notifier).fetchUserDetails();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
