import 'dart:async';
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
  ProviderSubscription? _subscription;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }

  Future<void> _checkAuth() async {
    final authService = ref.read(authServiceProvider);
    final token = await authService.getToken();

    if (!mounted) return;

    print(
      '[Splash] Token: ${(token != null || token?.isEmpty == true) ? "exists" : "null"}',
    );

    if (token == null || token.isEmpty) {
      print('[Splash] No token → GET_STARTED');
      context.go(Routes.GET_STARTED);
      return;
    }

    _subscription = ref.listenManual(userProvider, (prev, next) {
      final isLoading = next is AsyncLoading;
      print(
        '[Splash] userProvider changed: isLoading=$isLoading, value=${next.value}',
      );
      if (!isLoading && !_hasNavigated) {
        _hasNavigated = true;
        _subscription?.close();
        if (!mounted) return;
        _navigateBasedOnUser(next);
      }
    }, fireImmediately: true);
  }

  void _navigateBasedOnUser(AsyncValue userState) {
    final user = userState.value;
    print(
      '[Splash] Navigating: user=${user != null}, isKycVerified=${user?.isKycVerified}, agreementAccept=${user?.agreementAccept}',
    );

    if (user != null &&
        user.isKycVerified == true &&
        user.agreementAccept == true) {
      print('[Splash] → HOME');
      context.go(Routes.HOME);
    } else {
      print('[Splash] → KYC');
      context.go(Routes.KYC);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(child: ThreeDotsLoader()),
          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(child: ThreeDotsLoader()),
          ),
        ],
      ),
    );
  }
}
