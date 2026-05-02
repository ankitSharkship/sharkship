import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/auth/presentation/state/auth_notifier.dart';
import 'package:sharkship/features/more/presentation/widgets/menu_list_item.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/orders/presentation/widgets/address_picker_form.dart';
import 'package:sharkship/features/orders/presentation/widgets/courier_priority_form.dart';
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
    final balanceState = ref.watch(userBalanceProvider);
    Future<void> _onRefresh() async {
      ref.invalidate(userProvider);
      ref.invalidate(userBalanceProvider);
    }

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
            child: RefreshIndicator(
              onRefresh: () => _onRefresh(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProfileCard(context, user, ref, balanceState),
                      const SizedBox(height: 32),
                      _buildItems(context, ref),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context,
    dynamic user,
    WidgetRef ref,
    dynamic balanceState,
  ) {
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => context.push(Routes.USER_SCREEN),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            Text(
                              "View Profile",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF2D7FB8),
                                fontWeight: FontWeight.w700,
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
          GestureDetector(
            onTap: () {
              balanceState.value?.activeWallet != 'POSTPAID'
                  ? context.push(Routes.WALLET)
                  : null;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
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
                    Text(
                      "Total Balance",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D7FB8),
                      ),
                    ),
                    const Spacer(),
                    ref
                        .watch(userBalanceProvider)
                        .when(
                          data: (balance) => Text(
                            "₹${balance?.balance ?? '0.00'}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF5AB6E5),
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
                    Text(
                      "POSTPAID",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D7FB8),
                      ),
                    ),
                  ],
                ],
              ),
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
                  context.push(Routes.REMITTANCE_SUMMARY);
                },
              ),
              MenuItem(
                title: "Invoice Summary",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  context.push(Routes.INVOICE_SUMMARY);
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
                  context.push(Routes.BUYER_COMMUNICATION);
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
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => CourierPriorityForm(),
                  );
                },
              ),
              MenuItem(
                title: "Manage Pickup Address",
                icon: Icons.add_box_outlined,
                onTap: () {
                  context.push(Routes.ADDRESS_SCREEN);
                },
              ),
              MenuItem(
                title: "Customize Shipping Label",
                icon: Icons.local_shipping_outlined,
                onTap: () {
                  context.push(Routes.SHIPPING_LABEL);
                },
              ),
              MenuItem(
                title: "API Integration",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  context.push(Routes.API_INTEGRATION);
                },
              ),
              MenuItem(
                title: "Reports",
                icon: Icons.assignment_return_outlined,
                onTap: () {
                  context.push(Routes.GET_MIS_REPORTS);
                },
              ),
              // MenuItem(
              //   title: "Mange Users",
              //   icon: Icons.assignment_return_outlined,
              //   onTap: () {

              //   },
              // ),
            ],
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "KYC Info",
            icon: Icons.contact_emergency_outlined,
            onTap: () {
              context.push(Routes.KYC_INFO);
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Get Support",
            icon: Icons.support_agent,
            onTap: () {
              ref.read(bottomNavProvider.notifier).state = 3;
            },
          ),
        ),
        MenuListItem(
          item: MenuItem(
            title: "Channel Integrations",
            icon: Icons.settings_input_composite_outlined,
            onTap: () {

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
        title: Text("Logout", style: Theme.of(context).textTheme.titleLarge),
        content: Text("Are you sure you want to log out?", style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: Theme.of(context).textTheme.bodyLarge),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout(() {
                context.go('/splash');
              });
            },
            child: Text("Logout", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red)),
          ),
        ],
      ),
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
