import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/user/domain/entities/user.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/features/user/presentation/widget/user_profile_card.dart';
import 'package:sharkship/features/user/presentation/widget/edit_profile_sheet.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

import 'package:sharkship/features/user/presentation/state/profile_logo_notifier.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  final _dummyUser = User(
    id: '0',
    firstName: 'Loading',
    lastName: 'User',
    phoneNo: '0000000000',
    email: 'loading@email.com',
    status: '',
    verificationStatus: '',
    type: 'LOADING',
    isKycVerified: false,
    agreementAccept: false,
  );

  // final _dummyMetrics = TodayMetrics();
  @override
  Widget build(BuildContext context) {
    ref.listen(profileLogoProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          if (previous?.isLoading == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile picture updated successfully!'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        error: (err, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $err'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      );
    });

    final user = ref.watch(userProvider);
    final metricsState = ref.watch(todayMetricsProvider).value;
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      appBar: AppBar(
        backgroundColor: ColorManager.scaffoldBg,
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => showEditProfileSheet(context),
            icon: const Icon(Icons.edit),
          ),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              user.when(
                data: (data) {
                  return UserProfileCard(
                    user: data!,
                    todayMetrics: metricsState,
                  );
                },
                error: (err, st) => Center(
                  child: ErrorCard(
                    onRetry: () => ref.invalidate(userProvider),
                    errMssg: "Something went wrong",
                  ),
                ),
                loading: () {
                  return Skeletonizer(
                    enabled: true,
                    child: UserProfileCard(
                      user: _dummyUser,
                      todayMetrics: null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
