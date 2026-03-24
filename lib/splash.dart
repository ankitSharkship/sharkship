import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      // Trigger user data fetching after successful token detection
      await ref.read(userProvider.notifier).fetchUserDetails();
      if (!mounted) return;
      context.go('/home');
    } else {
      context.go('/get-started');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: ThreeDotsLoader()),
    );
  }
}
