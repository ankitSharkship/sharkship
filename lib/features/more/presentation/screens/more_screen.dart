import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/auth/presentation/state/auth_notifier.dart';
import 'package:sharkship/features/more/presentation/widgets/menu_list_item.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/shipments/presentation/state/shipment_tab_provider.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_balance_notifier.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      body: userAsync.when(
        loading: () => const Center(child: ThreeDotsLoader()),
        error: (err, st) => Center(child: Text("Error: $err")),
        data: (user) {
          if (user == null) {
            return const Center(child: Text("User not logged in"));
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildProfileCard(context, user, ref),
                  const SizedBox(height: 32),
                  _buildItems(context, ref),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, dynamic user, WidgetRef ref) {
    final balanceState = ref.watch(userBalanceProvider);
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
                    radius: 30,
                    backgroundColor: Colors.blue.shade50,
                    backgroundImage: user.profileImageUrl != null
                        ? CachedNetworkImageProvider(user.profileImageUrl!)
                        : null,
                    child: user.profileImageUrl == null
                        ? const Icon(Icons.person, size: 30, color: Colors.blue)
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
                        "${user.firstName} ${user.lastName ?? ""}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D7FB8).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF2D7FB8),
                    size: 19,
                  ),
                ),
                const SizedBox(width: 16),
                if (balanceState.value?.activeWallet != "POSTPAID") ...[
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D7FB8),
                    ),
                  ),
                  const Spacer(),
                  ref
                      .watch(userBalanceProvider)
                      .when(
                        data: (balance) => Text(
                          "₹${balance?.balance ?? '0.00'}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF5AB6E5),
                          ),
                        ),
                        loading: () => const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        error: (_, __) => const Text("₹0.00"),
                      ),
                ] else ...[
                  const Text(
                    "POSTPAID",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D7FB8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        MenuListItem(
          item: MenuItem(
            title: "Dashboard",
            icon: Icons.dashboard_outlined,
            onTap: () {
              ref.read(bottomNavProvider.notifier).state = 0;
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Orders",
            icon: Icons.inventory,
            isDropdown: true,
            children: [
              MenuItem(
                title: "Manage Orders",
                icon: Icons.description_outlined,
                onTap: () {
                  ref.read(bottomNavProvider.notifier).state = 1;
                },
              ),
              MenuItem(
                title: "Create Orders",
                icon: Icons.add_box_outlined,
                onTap: () {
                  context.push(Routes.CREATE_ORDER);
                },
              ),
              MenuItem(
                title: "Shipment Tracking",
                icon: Icons.local_shipping_outlined,
                onTap: () {
                  context.push(Routes.SHIPMENT_TRACKING);
                },
              ),
              MenuItem(
                title: "Returns",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  ref.read(shipmentTabProvider.notifier).state = 4;
                  ref.read(bottomNavProvider.notifier).state = 2;
                },
              ),
            ],
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "NDR",
            icon: Icons.assignment_return_outlined,
            onTap: () {
              context.push(Routes.NDR);
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Weight Discrepancy",
            icon: Icons.dashboard_outlined,
            onTap: () {
              context.push(Routes.WEIGHT_DISC);
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Finances",
            icon: Icons.wallet,
            isDropdown: true,
            children: [
              // MenuItem(
              //   title: "Shipping Charges",
              //   icon: Icons.description_outlined,
              //   onTap: () {
              //     _comingSoon(context);
              //   },
              // ),
              MenuItem(
                title: "Seller Charges",
                icon: Icons.add_box_outlined,
                onTap: () {
                  context.push(Routes.SELLER_CHARGES);
                },
              ),
              MenuItem(
                title: "Rate Calculator",
                icon: Icons.local_shipping_outlined,
                onTap: () {
                  context.push(Routes.RATE_CALCULATOR);
                },
              ),
              MenuItem(
                title: "Transaction Summary",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  context.push(Routes.TRANSACTION_SUMMARY);
                },
              ),
              MenuItem(
                title: "Remittance Summary",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
              MenuItem(
                title: "Invoice Summary",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
            ],
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Buyer Experience",
            icon: Icons.supervised_user_circle_outlined,
            isDropdown: true,
            children: [
              MenuItem(
                title: "Buyer Communication",
                icon: Icons.description_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
            ],
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Business Tools",
            icon: Icons.settings_applications_outlined,
            isDropdown: true,
            children: [
              MenuItem(
                title: "Courier Partner Priority",
                icon: Icons.description_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
              MenuItem(
                title: "Manage Pickup Address",
                icon: Icons.add_box_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
              MenuItem(
                title: "Customize Shipping Label",
                icon: Icons.local_shipping_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
              MenuItem(
                title: "API Integration",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
              MenuItem(
                title: "Reports",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
              MenuItem(
                title: "Mange Users",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  _comingSoon(context);
                },
              ),
            ],
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "KYC Verification",
            icon: Icons.contact_emergency_outlined,
            onTap: () {
              _comingSoon(context);
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Get Support",
            icon: Icons.support_agent,
            onTap: () {
              _comingSoon(context);
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Channel Integrations",
            icon: Icons.settings_input_composite_outlined,
            onTap: () {
              _comingSoon(context);
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Logout",
            icon: Icons.logout,
            onTap: () => _showLogoutDialog(context, ref),
          ),
        ),
      ],
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
