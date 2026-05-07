import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/shipments/domain/entities/tracking_event_entity.dart';
import 'package:sharkship/features/shipments/presentation/state/tracking_notifier.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/constants/app_text_styles.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class TrackingResult extends ConsumerStatefulWidget {
  final String trackingId;
  const TrackingResult({super.key, required this.trackingId});
  @override
  ConsumerState<TrackingResult> createState() => _TrackingResultState();
}

class _TrackingResultState extends ConsumerState<TrackingResult> {
  final TextEditingController _awbController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _awbController.text = widget.trackingId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDetails();
    });
  }

  Future<void> fetchDetails() async {
    await ref
        .read(trackingProvider.notifier)
        .fetchTrackingDetails(widget.trackingId);
  }

  @override
  Widget build(BuildContext context) {
    final trackingState = ref.watch(trackingProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text('Shipment Tracking'),
        backgroundColor: AppColors.lightBlueBg,
      ),
      body: trackingState.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text('Enter AWB to track'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17.0,
                    vertical: 15,
                  ),
                  child: Text(
                    "Let's Track your package",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),

                        // Truck icon
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0FB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.local_shipping_outlined,
                            color: Color(0xFF2B6FD4),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Text field
                        Expanded(
                          child: TextField(
                            controller: _awbController,
                            decoration: InputDecoration(
                              hintText: 'Enter AWB Number',
                              hintStyle: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color(0xFFB0B8C5),
                                    fontWeight: FontWeight.w400,
                                  ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 2),
                            ),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: const Color(0xFF111827)),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Track button
                        GestureDetector(
                          onTap: () {
                            // Handle track action
                            ref
                                .read(trackingProvider.notifier)
                                .fetchTrackingDetails(_awbController.text);
                          },
                          child: Container(
                            height: 56,
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2B6FD4),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(14),
                                bottomRight: Radius.circular(14),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Track',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),
                _buildInfoCard(
                  items: [
                    _InfoItem('AWB No.', data.trackingId),
                    _InfoItem('Order Id', data.sharkshipOrderId.toString()),
                    _InfoItem('Latest Status', data.courierStatus ?? '-'),
                    if (data.lastEventAt != null) ...[
                      _InfoItem(
                        'Updated At',
                        '${formatDateType2(data.lastEventAt!.toLocal().toString())}, ${formatTime(data.lastEventAt!.toLocal().toString())}',
                      ),
                    ],

                    if (data.pickupDate != null) ...[
                      _InfoItem(
                        'Pickup date',

                        '${formatDateType2(data.pickupDate.toString())}, ${formatTime(data.expectedDeliveryDate.toString())}',
                      ),
                    ],
                    if (data.expectedDeliveryDate != null) ...[
                      _InfoItem(
                        'ExpectedDelivery date',

                        '${formatDateType2(data.expectedDeliveryDate.toString())}, ${formatTime(data.expectedDeliveryDate.toString())}',
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 22),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4), // vertical lift
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'Tracking History',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        if (data.trackingInfo.isEmpty)
                          const Text('No tracking events found')
                        else ...[
                          TrackingTimeline(
                            events: data.trackingInfo,
                            currentIndex: 0,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                _buildAdditionalInfoCard(
                  title: 'ADDITIONAL INFORMATION',
                  items: [
                    _InfoItem(
                      'RECEIVER INFORMATION',
                      "${data.customerName}, ${data.customerAddress}",
                    ),
                    _InfoItem(
                      'SHIPMENT DETAILS',
                      "Package Weight: ${data.shipmentWeight}\n Dimensions: ${data.shipmentDimension} CM",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        error: (err, stacktrace) => Center(
          child: ErrorCard(
            onRetry: () => ref.invalidate(trackingProvider),
            errMssg: "Something went wrong",
          ),
        ),
        loading: () => Center(child: ThreeDotsLoader()),
      ),
    );
  }

  Widget _buildInfoCard({
    // required String title
    required List<_InfoItem> items,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4), // vertical lift
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                    Text(
                      item.value,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfoCard({
    required String title,
    required List<_InfoItem> items,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 1,
            offset: const Offset(0, 4), // vertical lift
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.secondaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Track Every Step, Stay Informed',
                  style: Theme.of(context).textTheme.titleLarge,
                  softWrap: true,
                ),
              ],
            ),
            const SizedBox(height: 22),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                          softWrap: true,
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  _InfoItem(this.label, this.value);
}

class TrackingTimeline extends StatelessWidget {
  final List<TrackingEventEntity> events;
  final int currentIndex;

  const TrackingTimeline({
    super.key,
    required this.events,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(events.length, (index) {
        final isCompleted = index < currentIndex;
        final isCurrent = index == currentIndex;

        return _TimelineItem(
          event: events[index],
          isCompleted: isCompleted,
          isCurrent: isCurrent,
          isLast: index == events.length - 1,
        );
      }),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final TrackingEventEntity event;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const _TimelineItem({
    required this.event,
    required this.isCompleted,
    required this.isCurrent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCompleted ? Colors.green : Colors.blue;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT DATE
          SizedBox(
            width: 60,
            child: Text(
              formatDate(event.dateTime.toString()),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// TIMELINE (LINE + DOT)
          SizedBox(
            width: 24,
            child: Column(
              children: [
                /// TOP LINE
                Expanded(
                  child: Container(
                    width: 3,
                    color: isCompleted ? Colors.green : Colors.blue,
                  ),
                ),

                /// DOT
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),

                /// BOTTOM LINE
                Expanded(
                  child: Container(
                    width: 3,
                    color: isLast
                        ? Colors.transparent
                        : (isCompleted ? Colors.green : Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.location.toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatTime(event.dateTime.toString()),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Remark: ${event.remark}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(String? dateTime) {
  if (dateTime == null) return '-';
  final dt = DateTime.tryParse(dateTime);
  if (dt == null) return '-';

  return '${dt.day} ${_month(dt.month)}';
}

String formatDateType2(String? dateTime) {
  if (dateTime == null) return '_';
  final dt = DateTime.tryParse(dateTime);
  if (dt == null) return '_';
  return '${dt.day}/${dt.month}/${dt.year}';
}

String formatTime(String? dateTime) {
  if (dateTime == null) return '-';
  final dt = DateTime.tryParse(dateTime);
  if (dt == null) return '-';

  final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
  final minute = dt.minute.toString().padLeft(2, '0');
  final period = dt.hour >= 12 ? 'PM' : 'AM';

  return '$hour:$minute $period';
}

String _month(int m) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[m - 1];
}
