import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/auth/presentation/state/auth_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: userAsync.when(
        loading: () => const Center(child: ThreeDotsLoader()),
        error: (err, st) => Center(child: Text("Error: $err")),
        data: (user) {
          if (user == null) {
            return const Center(child: Text("User not logged in"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProfileCard(context, user),
                const SizedBox(height: 32),
                _buildLogoutButton(context, ref),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, dynamic user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                /// Avatar with border
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue.shade50,
                    backgroundImage: user.profileImageUrl != null
                        ? CachedNetworkImageProvider(user.profileImageUrl!)
                        : null,
                    child: user.profileImageUrl == null
                        ? const Icon(Icons.person, size: 40, color: Colors.blue)
                        : null,
                  ),
                ),
                const SizedBox(width: 20),

                /// Name, Email, View Profile
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstName} ${user.lastName}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _comingSoon(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "View Profile",
                              style: TextStyle(
                                color: Color(0xFF2D7FB8),
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: Color(0xFF2D7FB8),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Dashed Divider
          _DashedDivider(),

          /// Balance Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D7FB8).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF2D7FB8),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D7FB8),
                  ),
                ),
                const Spacer(),
                const Text(
                  "₹100.00",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF5AB6E5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _showLogoutDialog(context, ref),
        icon: const Icon(Icons.logout),
        label: const Text("Log Out"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade50,
          foregroundColor: Colors.red,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.red.shade100),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout(() {
                context.go('/splash');
              });
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context) {
    GlobalPopups.showAlert(
      context: context,
      title: "Coming Soon",
      body: "Profile details will be available in the next update.",
      confirmText: "Got it",
      onConfirm: () => Navigator.pop(context),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashHeight = 1.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              ),
            );
          }),
        );
      },
    );
  }
}
