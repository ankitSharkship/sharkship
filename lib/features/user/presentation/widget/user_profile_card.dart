import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/features/home/domain/entities/today_metrics.dart';
import 'package:sharkship/features/nav/presentation/state/bottom_nav_state.dart';
import 'package:sharkship/features/user/domain/entities/user.dart';
import 'package:sharkship/features/user/presentation/state/profile_logo_notifier.dart';
import 'package:sharkship/features/user/presentation/widget/change_password_sheet.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class UserProfileCard extends ConsumerWidget {
  final User user;
  final TodayMetrics? todayMetrics;
  final VoidCallback? onChangePassword;

  const UserProfileCard({
    super.key,
    required this.user,
    required this.todayMetrics,
    this.onChangePassword,
  });

  String get fullName {
    return [
      user.firstName,
      user.middleName,
      user.lastName,
    ].where((e) => e != null && e.isNotEmpty).join(" ");
  }

  String get joinedDate {
    if (user.createdAt == null) return "-";
    try {
      final date = DateTime.parse(user.createdAt!);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (_) {
      return user.createdAt!;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: Colors.black.withValues(alpha: 0.04),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProfileAvatar(url: user.profileImageUrl),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user.type.toString(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color: user.isKycVerified
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              user.isKycVerified
                                  ? "KYC Verified"
                                  : "KYC Pending",
                              style: TextStyle(
                                color: user.isKycVerified
                                    ? Colors.green
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            Text(
                              user.agreementAccept
                                  ? "Accepted Terms & Conditions"
                                  : "Terms Not Accepted",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.open_in_new, size: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),

              const SizedBox(height: 8),

              _InfoRow(Icons.email_outlined, user.email),
              _InfoRow(Icons.phone_outlined, user.phoneNo),
              _InfoRow(Icons.person_outline, "Joined $joinedDate"),
              if (user.kam != null)
                _InfoRow(Icons.group_outlined, "KAM Name: ${user.kam!.name}"),
              if (user.kam != null)
                _InfoRow(Icons.mail_outline, "KAM Mail: ${user.kam!.email}"),

              const SizedBox(height: 16),

              // ===== CHANGE PASSWORD =====
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    if (onChangePassword != null) {
                      onChangePassword!();
                    } else {
                      showChangePasswordSheet(context);
                    }
                  },
                  icon: const Icon(Icons.key),
                  label: const Text(
                    "Change Password",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Colors.blue.shade700),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ===== STATS =====
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Account Statistics",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ref.read(bottomNavProvider.notifier).state = 0;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.insert_chart_outlined, size: 16),
                          SizedBox(width: 4),
                          Text("View"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(),

              const SizedBox(height: 8),

              if (todayMetrics != null) ...[
                if (todayMetrics?.todayOrderCount != null)
                  _StatRow(
                    "Today Order",
                    todayMetrics!.todayOrderCount.toString(),
                  ),
                if (todayMetrics?.todayRevenue != null)
                  _StatRow(
                    "Today Revenue",
                    "₹${todayMetrics!.todayRevenue ?? 0}",
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends ConsumerWidget {
  final String? url;

  const _ProfileAvatar({this.url});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(profileLogoProvider);

    return GestureDetector(
      onTap: () {
        if (!uploadState.isLoading) {
          ref.read(profileLogoProvider.notifier).pickAndUploadImage();
        }
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: Colors.blue.shade100,
            backgroundImage: (url != null && !uploadState.isLoading)
                ? NetworkImage(url!)
                : null,
            child: uploadState.isLoading
                ? const ThreeDotsLoader(size: 8)
                : (url == null ? const Icon(Icons.person, size: 36) : null),
          ),
          if (!uploadState.isLoading)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String title;
  final String? value;

  const _StatRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value ?? "0",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
