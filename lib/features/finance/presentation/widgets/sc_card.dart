import 'package:flutter/material.dart';
import '../../domain/entities/shipping_rate_entity.dart';
import '../../domain/entities/calculator_rate_entity.dart';

class ScCard extends StatefulWidget {
  final ShippingRateEntity? rate;
  final CalculatorRateEntity? calculatorRate;
  final int tab;
  const ScCard({
    super.key,
    this.rate,
    this.calculatorRate,
    required this.tab,
  });

  @override
  State<ScCard> createState() => _ScCardState();
}

class _ScCardState extends State<ScCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.calculatorRate != null) {
      return _buildCalculatorCard(widget.calculatorRate!);
    }
    
    final rate = widget.rate!;
    return _buildStandardCard(rate);
  }

  Widget _buildCalculatorCard(CalculatorRateEntity rate) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                rate.logo,
                height: 50,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.local_shipping, size: 50),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${rate.carrier} ${rate.baseWeight}Kg (${rate.courierType})',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _RateRow(
              label: 'Shipping Rate :',
              value: '₹${rate.rate ?? 0.0}',
              isBold: true,
            ),
            _RateRow(
              label: 'COD Charges :',
              value: '₹${rate.cod}',
              isBold: true,
            ),
            _RateRow(
              label: 'Base Weight :',
              value: '${rate.baseWeight} Kg',
            ),
             _RateRow(
              label: 'Additional Weight :',
              value: '${rate.additionalWeight} Kg',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardCard(ShippingRateEntity rate) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Center(
                  child: Image.network(
                    rate.logoUrl,
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.local_shipping, size: 50),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  '${rate.carrierName} ${rate.baseWeight}Kg (${rate.carrierType})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                // Base Rates
                const Row(
                  children: [
                    Text('📦 ', style: TextStyle(fontSize: 16)),
                    Text(
                      'Rates:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _RateRow(label: 'Within City :', value: '₹${rate.baseZone1}'),
                _RateRow(label: 'Within Zone :', value: '₹${rate.baseZone2}'),
                _RateRow(label: 'Metro City :', value: '₹${rate.baseZone3}'),
                _RateRow(label: 'Rest of India :', value: '₹${rate.baseZone4}'),
                _RateRow(label: 'Special Zone :', value: '₹${rate.baseZone5}'),

                // Expandable Section
                if (_isExpanded) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.add, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Additional (${rate.additionalWeight}Kg):',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _RateRow(
                    label: 'Within City :',
                    value: '₹${rate.additionalZone1}',
                  ),
                  _RateRow(
                    label: 'Within Zone :',
                    value: '₹${rate.additionalZone2}',
                  ),
                  _RateRow(
                    label: 'Metro City :',
                    value: '₹${rate.additionalZone3}',
                  ),
                  _RateRow(
                    label: 'Rest of India :',
                    value: '₹${rate.additionalZone4}',
                  ),
                  _RateRow(
                    label: 'Special Zone :',
                    value: '₹${rate.additionalZone5}',
                  ),
                ],

                const SizedBox(height: 16),

                // COD Info
                _RateRow(
                  label: 'COD Charges :',
                  value: '₹${rate.cod}',
                  isBold: true,
                ),
                _RateRow(
                  label: 'COD % :',
                  value: '${rate.codPercentage}%',
                  isBold: true,
                ),
              ],
            ),
          ),

          // Show More/Less Button
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded ? 'Show Less' : 'Show More',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RateRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _RateRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
