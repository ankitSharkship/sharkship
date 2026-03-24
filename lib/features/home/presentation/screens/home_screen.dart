import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../../../../features/auth/presentation/state/auth_notifier.dart';
import '../../../../shared/widgets/global_popups.dart';
import '../../../../features/user/presentation/state/user_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              GlobalPopups.showAlert(
                context: context,
                title: 'Logout',
                body: 'Are you sure you want to log out?',
                confirmText: 'Logout',
                onConfirm: () {
                  ref.read(userProvider.notifier).clearUser();
                  ref.read(authProvider.notifier).logout(() {
                    if (context.mounted) {
                      context.go('/signin');
                    }
                  }, allSession: false);
                },
              );
            },
          ),
        ],
      ),
      body: userState.when(
        loading: () => const Center(child: ThreeDotsLoader()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (user) {
          final userName = user?.firstName ?? 'User';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user?.profileImageUrl != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user!.profileImageUrl!),
                  )
                else
                  const Icon(Icons.waving_hand, size: 64, color: Colors.amber),
                const SizedBox(height: 20),
                Text(
                  'Welcome, $userName!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                if (user?.type != null)
                  Text(
                    'Plan: ${user?.type}',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                const SizedBox(height: 8),
                if (user?.businessName != null)
                  Text(
                    'Business: ${user?.businessName}',
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
