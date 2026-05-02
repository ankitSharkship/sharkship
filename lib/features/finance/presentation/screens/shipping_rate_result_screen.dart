import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import '../../domain/entities/calculator_rate_entity.dart';
import '../widgets/sc_card.dart'; // I will modify ScCard to handle this

class ShippingRateResultScreen extends StatelessWidget {
  final List<CalculatorRateEntity> rates;

  const ShippingRateResultScreen({super.key, required this.rates});

  @override
  Widget build(BuildContext context) {
    final surfaceRates = rates.where((r) => r.courierType.toUpperCase() == 'SURFACE').toList();
    final airRates = rates.where((r) => r.courierType.toUpperCase() == 'AIR').toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBg,
        appBar: AppBar(
          title: Text(
            'Shipping Rate',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Surface'),
              Tab(text: 'Air'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(rates),
            _buildList(surfaceRates),
            _buildList(airRates),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<CalculatorRateEntity> list) {
    if (list.isEmpty) {
      return const Center(child: Text('No rates available for this category'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: list.length,
      itemBuilder: (context, index) {
        // ScCard will be modified to support CalculatorRateEntity
        return ScCard(
          calculatorRate: list[index],
          tab: 0, // Dummy tab value
        );
      },
    );
  }
}
