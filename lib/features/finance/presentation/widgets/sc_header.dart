import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/shared/constants/colors.dart';

class ScHeader extends ConsumerWidget {
  const ScHeader({super.key});

  void _showInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const InfoModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 28),
              ),
              const Text(
                "Seller Charges",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _showInfoSheet(context),
                icon: const Icon(Icons.info, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoModal extends StatelessWidget {
  const InfoModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 46),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            /// CLOSE BUTTON
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.close, size: 18, color: Colors.white),
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 8),

                    Text(
                      "NOTES:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),

                    _NoteItem(
                      "Dead/Dry weight or volumetric weight whichever is higher will be taken while calculating the freight rates.",
                    ),
                    _NoteItem(
                      "Fixed COD charge or COD % of the order value whichever is higher will be taken while calculating the COD fee.",
                    ),
                    _NoteItem(
                      "Above prices are inclusive of GST and Fuel Surcharge.",
                    ),
                    _NoteItem(
                      "The above pricing is subject to change based on fuel charges and courier company base rates. Volumetric weight is calculated LxBxH/4750 for all courier companies it is LxBxH/4750 (length, breadth, height has to be taken in Centimeters and divided by denominator, this will give the value in Kilograms).",
                    ),
                    _NoteItem(
                      "Other Charges like Octroi charges, state entry tax and fees, address correction charges if applicable shall be charged extra.",
                    ),
                    _NoteItem(
                      "RTO (return to origin) shipment will be charged differently from the forward delivery rate.",
                    ),
                    _NoteItem(
                      "The maximum liability if any is limited to whatever compensation the logistics partner offers to Company in event of a claim by the Merchant, provided such claim is raised by the Merchant within one (1) month from the date of such damage or loss or theft.",
                    ),
                    _NoteItem(
                      "Sharkship shall not assist in shipping goods that come under the category of prohibited, dangerous goods or restricted good.",
                    ),

                    SizedBox(height: 8),

                    Text(
                      "9. For any queries please mail to",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),

                    Text(
                      "support@sharkship.in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
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
}

class _NoteItem extends StatelessWidget {
  final String text;

  const _NoteItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
