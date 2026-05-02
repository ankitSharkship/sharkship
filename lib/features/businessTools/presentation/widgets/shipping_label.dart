import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sharkship/shared/constants/app_colors.dart';

class ShippingLabelController {
  final TextEditingController newNameController = TextEditingController();

  bool get logoVisibility => true;
  bool get alterName => false;
  bool get phoneVisibility => false;
  bool get isAmountVisible => true;
  bool get clientVisibility => false;
  bool get tableVisibility => true;
  bool get skuVisibility => true;
  bool get rtoVisibility => true;
  bool get rtoPhoneVisibility => true;
  bool get gstVisibility => true;
  bool get sharkshipVisibility => true;

  String get newName => !alterName ? 'business name' : newNameController.text;

  void dispose() {
    newNameController.dispose();
  }
}

class ShippingLabel extends StatefulWidget {
  final ShippingLabelController? controller;

  const ShippingLabel({Key? key, this.controller}) : super(key: key);

  @override
  State<ShippingLabel> createState() => _ShippingLabelState();
}

class _ShippingLabelState extends State<ShippingLabel> {
  late ShippingLabelController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ShippingLabelController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final containerPadding = 8.0;
    final contentPadding = 6.0;
    final maxWidth = screenWidth - 32;
    final borderWidth = 1.0;
    final fontSize = 10.0;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text('Shipping Label Preview'),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBg,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: containerPadding,
                vertical: containerPadding,
              ),
              constraints: BoxConstraints(maxWidth: maxWidth),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: borderWidth),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // ═══════════════════════════════════════════════════════
                  // HEADER SECTION
                  // ═══════════════════════════════════════════════════════
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(contentPadding),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: borderWidth,
                          ),
                        ),
                      ),
                      child: _buildMobileHeader(
                        fontSize,
                        contentPadding,
                        _controller.newName,
                      ),
                    ),
                  ),

                  // ═══════════════════════════════════════════════════════
                  // PREPAID SECTION
                  // ═══════════════════════════════════════════════════════
                  Container(
                    padding: EdgeInsets.all(containerPadding),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: borderWidth,
                        ),
                      ),
                    ),
                    child: _buildMobilePrepaid(fontSize, borderWidth),
                  ),

                  // ═══════════════════════════════════════════════════════
                  // TABLE SECTION
                  // ═══════════════════════════════════════════════════════
                  if (_controller.tableVisibility)
                    Container(
                      padding: EdgeInsets.all(containerPadding),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: borderWidth,
                          ),
                        ),
                      ),
                      child: _buildTable(fontSize, borderWidth),
                    ),

                  // ═══════════════════════════════════════════════════════
                  // FOOTER SECTION
                  // ═══════════════════════════════════════════════════════
                  Container(
                    padding: EdgeInsets.all(containerPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: containerPadding),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: borderWidth,
                              ),
                            ),
                          ),
                          child: _buildMobileFooter(fontSize),
                        ),
                        SizedBox(height: containerPadding),
                        _buildLegalText(fontSize),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Powered by Sharkship
            if (_controller.sharkshipVisibility)
              Padding(
                padding: EdgeInsets.only(
                  bottom: containerPadding,
                  right: containerPadding,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'powered By Sharkship',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: fontSize - 2,
                          color: Colors.grey[600],
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // HEADER BUILDERS
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildMobileHeader(double fontSize, double padding, String newName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To,',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: Colors.black,
                      ),
                ),
                Text(
                  'xyz, ground floor, Janick Villa Gate number 4',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        height: 1.2,
                        color: Colors.black,
                      ),
                ),
                Text(
                  'Near Community center',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        height: 1.2,
                        color: Colors.black,
                      ),
                ),
                Text(
                  'Thane (west), New delhi - 110034',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        height: 1.2,
                        color: Colors.black,
                      ),
                ),
                if (_controller.phoneVisibility)
                  Text(
                    'Contact No : 91-9958939238',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: fontSize,
                          height: 1.2,
                          color: Colors.black,
                        ),
                  ),
              ],
            ),
            if (_controller.logoVisibility)
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              '{',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 40,
                                    color: Colors.black,
                                  ),
                            ),
                            Text(
                              'YOUR\nLOGO\nHERE',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: fontSize - 2,
                                    color: Colors.black,
                                  ),
                            ),
                            Text(
                              '}',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 40,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      newName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
            if (_controller.logoVisibility) SizedBox(height: padding * 2),
          ],
        ),
        if (_controller.alterName) Text(newName),
        // Address
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // PREPAID BUILDERS
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildMobilePrepaid(double fontSize, double borderWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Amount
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PREPAID',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            if (_controller.isAmountVisible)
              Text(
                'Rs. 10450',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            const SizedBox(height: 8),

            // Details
            Text(
              'Dimension: 10 cm x 10 cm x 10 cm',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: fontSize - 1,
                    color: Colors.black,
                  ),
            ),
            Text(
              'Weight: 0.5kg',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: fontSize - 1,
                    color: Colors.black,
                  ),
            ),
            if (_controller.clientVisibility)
              Text(
                'ClientId: MH0712224',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize - 1,
                      color: Colors.black,
                    ),
              ),

            const SizedBox(height: 12),
          ],
        ),

        // Barcode Section
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DELHIVERY',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/businessTools/barcode.svg',
                  height: 40,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AWB : #3373289772123034584759',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize - 1,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // TABLE BUILDER
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildTable(double fontSize, double borderWidth) {
    return Table(
      border: TableBorder.all(color: Colors.black, width: borderWidth),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header
        TableRow(
          children: [
            if (_controller.skuVisibility)
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  'SKU',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'ITEM',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'QTY',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'AMT',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
        // Row 1
        TableRow(
          children: [
            if (_controller.skuVisibility)
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  'Sample SKU',
                  style: TextStyle(fontSize: fontSize - 1),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'Jewellery',
                style: TextStyle(fontSize: fontSize - 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                '1',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize - 1,
                      color: Colors.black,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                '9999',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize - 1,
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        ),
        // Row 2
        TableRow(
          children: [
            if (_controller.skuVisibility)
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  'Sample SKU',
                  style: TextStyle(fontSize: fontSize - 1),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('T-SHirt', style: TextStyle(fontSize: fontSize - 1)),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('2', style: TextStyle(fontSize: fontSize - 1)),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('999', style: TextStyle(fontSize: fontSize - 1)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileFooter(double fontSize) {
    bool isQrCenter =
        !_controller.rtoVisibility &&
        !_controller.rtoPhoneVisibility &&
        !_controller.gstVisibility;
    return Row(
      mainAxisAlignment: isQrCenter
          ? MainAxisAlignment.center
          : MainAxisAlignment.spaceBetween,
      children: [
        if (isQrCenter) ...[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_controller.rtoVisibility) ...[
                Text(
                  'Pickup & Return Address:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                Text(
                  'xyz, ground floor, Janick Villa Gate number 4',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize - 1,
                        color: Colors.black,
                      ),
                ),
                Text(
                  'Near Community center',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize - 1,
                        color: Colors.black,
                      ),
                ),
                Text(
                  'Thane (west), New Delhi - 110034',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize - 1,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 6),
              ],
              if (_controller.rtoPhoneVisibility)
                Text(
                  'Contact No : 91-9958939238',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize - 1,
                        color: Colors.black,
                      ),
                ),
              if (_controller.gstVisibility)
                Text(
                  'GST : 237JS7347',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: fontSize - 1,
                        color: Colors.black,
                      ),
                ),
              const SizedBox(height: 12),
            ],
          ),
        ],
        // Order & QR
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order #764123',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.qr_code_2_outlined, size: 70),
              const SizedBox(height: 6),
              Text(
                'Date: Nov 22, 2024',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: fontSize - 2,
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // LEGAL TEXT
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildLegalText(double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '* Customer service working label is closed temporarily/damaged do not accept parcel. All disputes are subject to Delhi jurisdiction only.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: fontSize - 2,
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          '* Please check the delivery value while opening the parcel. This sales is mandatory for raising any disputes on wrong products.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: fontSize - 2,
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          '* THIS IS AN AUTO-GENERATED LABEL AND DOES NOT NEED ANY SIGNATURE.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: fontSize - 3,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
      ],
    );
  }
}
