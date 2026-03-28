import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import 'core/providers/app_providers.dart';
import 'features/user/presentation/state/user_notifier.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authService = ref.read(authServiceProvider);
    final token = await authService.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // final userNotifier = ref.read(userProvider.notifier);
      final userState = ref.read(userProvider);

      if (!mounted) return;
      print('+++++++++++++++++++++++++++++');
      print(userState.value);
      if (userState.value != null && userState.value?.isKycVerified == true) {
        context.go(Routes.HOME);
      } else {
        context.go(Routes.KYC);
      }
    } else {
      context.go(Routes.GET_STARTED);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: ThreeDotsLoader()));
  }
}
