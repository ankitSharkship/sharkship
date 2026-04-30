import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_notifier.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_tab_provider.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

class RaiseTicketSheet extends ConsumerStatefulWidget {
  const RaiseTicketSheet({super.key});

  @override
  ConsumerState<RaiseTicketSheet> createState() => _RaiseTicketSheetState();
}

class _RaiseTicketSheetState extends ConsumerState<RaiseTicketSheet> {
  final TextEditingController _issueController = TextEditingController();

  String _selectedCategory = "FINANCE";

  final List<String> categories = [
    "FINANCE",
    "TECHNICAL",
    "CUSTOMER_SUPPORT",
    "OPERATIONS",
  ];

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// drag handle
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          /// header
          Row(
            children: const [
              Icon(Icons.confirmation_number_outlined),
              SizedBox(width: 8),
              Text(
                "Raise Ticket",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),

          const SizedBox(height: 4),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Raise a ticket for your issue.",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          const SizedBox(height: 20),

          /// CATEGORY
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 8),

          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: categories
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedCategory = value);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            dropdownColor: Colors.white,
          ),
          const SizedBox(height: 20),

          /// ISSUE
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Issue", style: TextStyle(fontWeight: FontWeight.w600)),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _issueController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Enter your issue here...",
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              onTap: () async {
                final issue = _issueController.text.trim();

                if (issue.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter issue")),
                  );
                  return;
                }

                try {
                  // Use the currently selected tab to ensure the right provider is refreshed
                  final currentTab = ref.read(ticketsTabProvider);
                  await ref
                      .read(ticketsProvider(currentTab).notifier)
                      .createTicket(
                        category: _selectedCategory,
                        userNote: issue,
                        onSuccess: (msg) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(msg)));
                        },
                      );
                  ref.invalidate(ticketsProvider(currentTab));
                  if (mounted) Navigator.pop(context);
                } catch (e) {
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: ${e.toString()}")),
                    );
                  }
                }
              },
              text: "Submit",
            ),
          ),
        ],
      ),
    );
  }
}
