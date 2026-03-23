import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../network/dio_client.dart';
import '../services/auth_service.dart';

part 'app_providers.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}

@riverpod
DioClient dioClient(Ref ref) {
  final auth = ref.watch(authServiceProvider);
  return DioClient.create(auth);
}
