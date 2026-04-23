// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sharkship/features/finance/domain/usecases/get_remittance_details_usecase.dart';
// import 'package:sharkship/features/finance/presentation/state/remittance_notifier.dart';

// import 'package:sharkship/features/home/presentation/widgets/shipment_stat_card.dart';

// import 'package:sharkship/routes/app_router.dart';
// import 'package:sharkship/shared/widgets/global_popups.dart';
// // import 'package:sharkship/shared/widgets/loader.dart';
// import 'package:skeletonizer/skeletonizer.dart';


// class RsGrid extends ConsumerWidget {
//   const RsGrid({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final statusState = ref.watch(remittanceProvider);

//     return statusState.when(
//       loading: () => const NDRGridSkeleton(),
//       error: (err, stack) => Center(child: Text('Error: $err')),
//       data: (summary) {
//         if (summary.countByNDRStatus.isEmpty) {
//           return const SizedBox.shrink();
//         }

//         final group = summary.countByNDRStatus.first;

//         final items = [
//           ("NDR Order", group.totalNdrOrders.toString(), Icons.sync),
//           ("Reattempted", group.totalReattempted.toString(), Icons.check_box),
//           (
//             "NDR Delivered",
//             group.totalDelivered.toString(),
//             Icons.local_shipping,
//           ),
//           (
//             "NDR Returned",
//             group.totalReturned.toString(),
//             Icons.delivery_dining,
//           ),
//         ];

//         return LayoutBuilder(
//           builder: (context, constraints) {
//             final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

//             return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: items.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 mainAxisExtent: 70,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//               ),
//               itemBuilder: (_, i) => ShipmentStatCard(
//                 title: items[i].$1,
//                 value: items[i].$2,
//                 icon: items[i].$3,
//                 onTap: () {
                  
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void _comingSoon(BuildContext context) {
//     GlobalPopups.showAlert(
//       context: context,
//       title: "Coming Soon",
//       body: "This feature is coming soon",
//       confirmText: "OK",
//       onConfirm: () => Navigator.pop(context),
//     );
//   }
// }

// class NDRGridSkeleton extends StatelessWidget {
//   const NDRGridSkeleton();

//   @override
//   Widget build(BuildContext context) {
//     final fakeItems = [
//       ("Loading", "----", 0.0, Icons.inventory),
//       ("Loading", "----", 0.0, Icons.show_chart),
//       ("Loading", "----", 0.0, Icons.history),
//       ("Loading", "----", 0.0, Icons.paid_outlined),
//       ("Loading", "----", 0.0, Icons.history),
//       ("Loading", "----", 0.0, Icons.paid_outlined),
//     ];

//     return Skeletonizer(
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
//           return GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: fakeItems.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: crossAxisCount,
//               mainAxisExtent: 70,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//             ),
//             itemBuilder: (_, i) => ShipmentStatCard(
//               title: fakeItems[i].$1,
//               value: fakeItems[i].$2,
//               icon: fakeItems[i].$4,
//               onTap: () {},
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
