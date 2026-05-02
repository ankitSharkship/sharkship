import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_notifier.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_tab_provider.dart';
import 'package:sharkship/features/tickets/presentation/widgets/add_ticket.dart';
import 'package:sharkship/features/tickets/presentation/widgets/ticket_card.dart';
import 'package:sharkship/features/tickets/presentation/widgets/tickets_header.dart';
import 'package:sharkship/features/tickets/presentation/widgets/tickets_tabbar.dart';
import 'package:sharkship/shared/constants/colors.dart';

class TicketsScreen extends ConsumerStatefulWidget {
  const TicketsScreen({super.key});
  @override
  ConsumerState<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends ConsumerState<TicketsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  void _loadMore() {
    final selectedTab = ref.read(ticketsTabProvider);
    final notifier = ref.read(ticketsProvider(selectedTab).notifier);
    notifier.loadMore();
  }

  Future<void> _onRefresh(int tab) async {
    ref.invalidate(ticketsProvider(tab));
    return ref.read(ticketsProvider(tab).future);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showRaiseTicketSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.lightBlueBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const RaiseTicketSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(ticketsTabProvider);
    final ticketsState = ref.watch(ticketsProvider(selectedTab));

    return Scaffold(
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [ColorManager.primaryBlue, ColorManager.secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          heroTag: 'tickets_fab',
          onPressed: () => showRaiseTicketSheet(context),
          backgroundColor: Colors.transparent,
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const TicketsHeader(),
            const TicketsTabbar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedTab),
                child: ticketsState.when(
                  data: (state) {
                    final data = state.data;
                    final tickets = data?.tickets ?? [];

                    if (state.isFiltering) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (tickets.isEmpty) {
                      return ListView(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [_emptyState()],
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 100),
                      itemCount: tickets.length + 1,
                      itemBuilder: (context, index) {
                        if (index == tickets.length) {
                          if (state.isLoadingMore) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return const SizedBox.shrink();
                        }

                        final ticket = tickets[index];
                        return TicketCard(
                          category: ticket.category,
                          createdDate:
                              "${ticket.queryDate.day}/${ticket.queryDate.month}/${ticket.queryDate.year}",
                          description: ticket.userNote,
                          adminNote: ticket.adminNote,
                          resolvedDate: ticket.resolvedDate != null
                              ? "${ticket.resolvedDate!.day}/${ticket.resolvedDate!.month}/${ticket.resolvedDate!.year}"
                              : null,
                        );
                      },
                    );
                  },
                  error: (err, st) => ListView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(child: Text("Error: ${err.toString()}")),
                      ),
                    ],
                  ),
                  loading: () => const OrdersSkeletonList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SvgPicture.asset(
            'assets/images/tickets/help&support.svg',
            height: 300,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'All Caught Up',
          style: TextStyle(
            fontSize: 20,
            color: ColorManager.secondaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "You have no open support tickets at the\n moment. Need help? We're just a click away.",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
