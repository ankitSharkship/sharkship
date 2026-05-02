import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/global_popups.dart';

class HomeHeader extends StatelessWidget {
  final String? name;
  final String? profileUrl;
  const HomeHeader({super.key, required this.name, required this.profileUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Profile + Welcome
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: profileUrl != null && profileUrl!.isNotEmpty
                    ? CachedNetworkImageProvider(profileUrl!)
                    : null,
                child: (profileUrl == null || profileUrl!.isEmpty)
                    ? const Icon(Icons.person)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name ?? "User",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        /// Notification Icon
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            const Positioned(
              right: 8,
              top: 8,
              child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
            ),
          ],
        ),

        /// Wallet Badge
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  "₹ 12000.99",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
