import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderCardSkeleton extends StatelessWidget {
  const OrderCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 120, height: 20, color: Colors.grey),
                Row(
                  children: [
                    Container(width: 30, height: 30),
                    const SizedBox(width: 10),
                    Container(width: 30, height: 30),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            /// Main row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 24, height: 24),
                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 100),
                      const SizedBox(height: 6),
                      Container(height: 12, width: 140),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(width: 20, height: 20),
                          const SizedBox(width: 8),
                          Container(width: 20, height: 20),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(height: 16, width: 80),
                    const SizedBox(height: 8),
                    Container(height: 20, width: 100),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Rows
            _rowSkeleton(),
            _rowSkeleton(),
            _rowSkeleton(),

            const SizedBox(height: 16),

            /// Footer
            Center(
              child: Container(height: 14, width: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 120, height: 12),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 12)),
        ],
      ),
    );
  }
}

class OrdersSkeletonList extends StatelessWidget {
  final int itemCount;
  const OrdersSkeletonList({super.key, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (_, __) => const OrderCardSkeleton(),
    );
  }
}