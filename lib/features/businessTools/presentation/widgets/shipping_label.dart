import 'package:flutter/material.dart';

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

  String get newName =>
      newNameController.text.isEmpty ? 'business name' : newNameController.text;

  void dispose() {
    newNameController.dispose();
  }
}

class ShippingLabel extends StatefulWidget {
  final ShippingLabelController? controller;

  const ShippingLabel({
    Key? key,
    this.controller,
  }) : super(key: key);

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
    final isMobile = screenWidth < 600;
    final containerPadding = isMobile ? 8.0 : 16.0;
    final contentPadding = isMobile ? 6.0 : 8.0;
    final maxWidth = isMobile ? screenWidth - 32 : 600.0;
    final borderWidth = isMobile ? 1.5 : 2.0;
    final fontSize = isMobile ? 10.0 : 12.0;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: containerPadding, vertical: containerPadding),
            constraints: BoxConstraints(maxWidth: maxWidth),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: borderWidth),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // ═══════════════════════════════════════════════════════
                // HEADER SECTION
                // ═══════════════════════════════════════════════════════
                Container(
                  padding: EdgeInsets.all(contentPadding),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: borderWidth),
                    ),
                  ),
                  child: isMobile
                      ? _buildMobileHeader(fontSize, contentPadding)
                      : _buildDesktopHeader(fontSize, contentPadding),
                ),

                // ═══════════════════════════════════════════════════════
                // PREPAID SECTION
                // ═══════════════════════════════════════════════════════
                Container(
                  padding: EdgeInsets.all(containerPadding),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: borderWidth),
                    ),
                  ),
                  child: isMobile
                      ? _buildMobilePrepaid(fontSize, borderWidth)
                      : _buildDesktopPrepaid(fontSize, borderWidth),
                ),

                // ═══════════════════════════════════════════════════════
                // TABLE SECTION
                // ═══════════════════════════════════════════════════════
                if (_controller.tableVisibility)
                  Container(
                    padding: EdgeInsets.all(containerPadding),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black, width: borderWidth),
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
                            bottom: BorderSide(color: Colors.black, width: borderWidth),
                          ),
                        ),
                        child: isMobile
                            ? _buildMobileFooter(fontSize)
                            : _buildDesktopFooter(fontSize),
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
              padding: EdgeInsets.only(bottom: containerPadding, right: containerPadding),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'powered By Sharkship',
                  style: TextStyle(
                    fontSize: fontSize - 2,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // HEADER BUILDERS
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildMobileHeader(double fontSize, double padding) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo
        if (_controller.logoVisibility)
          Center(
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  'LOGO',
                  style: TextStyle(fontSize: fontSize - 2, color: Colors.grey[400]),
                ),
              ),
            ),
          ),
        if (_controller.logoVisibility) SizedBox(height: padding * 2),

        // Business Name
        if (_controller.alterName)
          Text(
            _controller.newName,
            style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.w600),
          )
        else
          Text(
            'business name',
            style: TextStyle(fontSize: fontSize + 1, color: Colors.blue),
          ),
        SizedBox(height: padding * 2),

        // Address
        Text(
          'To,',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        Text(
          'xyz, ground floor, Janick Villa Gate number 4',
          style: TextStyle(fontSize: fontSize, height: 1.2),
        ),
        Text(
          'Near Community center',
          style: TextStyle(fontSize: fontSize, height: 1.2),
        ),
        Text(
          'Thane (west), New delhi - 110034',
          style: TextStyle(fontSize: fontSize, height: 1.2),
        ),
        if (_controller.phoneVisibility)
          Text(
            'Contact No : 91-9958939238',
            style: TextStyle(fontSize: fontSize, height: 1.2),
          ),
      ],
    );
  }

  Widget _buildDesktopHeader(double fontSize, double padding) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Address
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'To,',
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              Text(
                'xyz, ground floor, Janick Villa Gate number 4',
                style: TextStyle(fontSize: fontSize, height: 1.2),
              ),
              Text(
                'Near Community center',
                style: TextStyle(fontSize: fontSize, height: 1.2),
              ),
              Text(
                'Thane (west), New delhi - 110034',
                style: TextStyle(fontSize: fontSize, height: 1.2),
              ),
              if (_controller.phoneVisibility)
                Text(
                  'Contact No : 91-9958939238',
                  style: TextStyle(fontSize: fontSize, height: 1.2),
                ),
            ],
          ),
        ),
        SizedBox(width: padding * 2),

        // Logo & Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_controller.logoVisibility)
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    'LOGO',
                    style: TextStyle(fontSize: fontSize - 2, color: Colors.grey[400]),
                  ),
                ),
              ),
            SizedBox(height: padding),
            if (_controller.alterName)
              Text(
                _controller.newName,
                style: TextStyle(
                  fontSize: fontSize + 1,
                  fontWeight: FontWeight.w600,
                ),
              )
            else
              Text(
                'business name',
                style: TextStyle(fontSize: fontSize + 1, color: Colors.blue),
              ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // PREPAID BUILDERS
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildMobilePrepaid(double fontSize, double borderWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Amount
        Row(
          children: [
            Text(
              'PREPAID',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            if (_controller.isAmountVisible)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Rs. 10450',
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),

        // Details
        Text(
          'Dimension: 10 cm x 10 cm x 10 cm',
          style: TextStyle(fontSize: fontSize - 1),
        ),
        Text(
          'Weight: 0.5kg',
          style: TextStyle(fontSize: fontSize - 1),
        ),
        if (_controller.clientVisibility)
          Text(
            'ClientId: MH0712224',
            style: TextStyle(fontSize: fontSize - 1),
          ),

        const SizedBox(height: 12),

        // Barcode Section
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DELHIVERY',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  border: Border.all(color: Colors.black, width: borderWidth),
                ),
                child: Center(
                  child: Text(
                    'BARCODE',
                    style: TextStyle(fontSize: fontSize - 2, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'AWB : #3373289772123034584759',
                style: TextStyle(fontSize: fontSize - 1, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopPrepaid(double fontSize, double borderWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'PREPAID',
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
                if (_controller.isAmountVisible)
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Rs. 10450',
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Dimension: 10 cm x 10 cm x 10 cm',
              style: TextStyle(fontSize: fontSize),
            ),
            Text(
              'Weight: 0.5kg',
              style: TextStyle(fontSize: fontSize),
            ),
            if (_controller.clientVisibility)
              Text(
                'ClientId: MH0712224',
                style: TextStyle(fontSize: fontSize),
              ),
          ],
        ),

        // Barcode
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DELHIVERY',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green[500],
                border: Border.all(color: Colors.black, width: borderWidth),
              ),
              child: Center(
                child: Text(
                  'BARCODE',
                  style: TextStyle(fontSize: fontSize - 2, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'AWB : #3373289772123034584759',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ],
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
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'ITEM',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'QTY',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                'AMT',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
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
                child: Text('Sample SKU', style: TextStyle(fontSize: fontSize - 1)),
              ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('Jewellery', style: TextStyle(fontSize: fontSize - 1)),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('1', style: TextStyle(fontSize: fontSize - 1)),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text('9999', style: TextStyle(fontSize: fontSize - 1)),
            ),
          ],
        ),
        // Row 2
        TableRow(
          children: [
            if (_controller.skuVisibility)
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text('Sample SKU', style: TextStyle(fontSize: fontSize - 1)),
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

  // ═══════════════════════════════════════════════════════════════════════
  // FOOTER BUILDERS
  // ═══════════════════════════════════════════════════════════════════════

  Widget _buildMobileFooter(double fontSize) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_controller.rtoVisibility) ...[
          Text(
            'Pickup & Return Address:',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          Text(
            'xyz, ground floor, Janick Villa Gate number 4',
            style: TextStyle(fontSize: fontSize - 1),
          ),
          Text(
            'Near Community center',
            style: TextStyle(fontSize: fontSize - 1),
          ),
          Text(
            'Thane (west), New Delhi - 110034',
            style: TextStyle(fontSize: fontSize - 1),
          ),
          const SizedBox(height: 6),
        ],
        if (_controller.rtoPhoneVisibility)
          Text(
            'Contact No : 91-9958939238',
            style: TextStyle(fontSize: fontSize - 1),
          ),
        if (_controller.gstVisibility)
          Text(
            'GST : 237JS7347',
            style: TextStyle(fontSize: fontSize - 1),
          ),
        const SizedBox(height: 12),

        // Order & QR
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order #764123',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    'QR',
                    style: TextStyle(fontSize: fontSize - 2, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Date: Nov 22, 2024',
                style: TextStyle(fontSize: fontSize - 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopFooter(double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_controller.rtoVisibility) ...[
              Text(
                'Pickup & Return Address:',
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              Text(
                'xyz, ground floor, Janick Villa Gate number 4',
                style: TextStyle(fontSize: fontSize - 1),
              ),
              Text(
                'Near Community center',
                style: TextStyle(fontSize: fontSize - 1),
              ),
              Text(
                'Thane (west), New Delhi - 110034',
                style: TextStyle(fontSize: fontSize - 1),
              ),
            ],
            if (_controller.rtoPhoneVisibility)
              Text(
                'Contact No : 91-9958939238',
                style: TextStyle(fontSize: fontSize - 1),
              ),
            if (_controller.gstVisibility)
              Text(
                'GST : 237JS7347',
                style: TextStyle(fontSize: fontSize - 1),
              ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order #764123',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green[500],
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  'QR',
                  style: TextStyle(fontSize: fontSize - 2, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: Nov 22, 2024',
              style: TextStyle(fontSize: fontSize - 1),
            ),
          ],
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
          style: TextStyle(fontSize: fontSize - 2),
        ),
        const SizedBox(height: 4),
        Text(
          '* Please check the delivery value while opening the parcel. This sales is mandatory for raising any disputes on wrong products.',
          style: TextStyle(fontSize: fontSize - 2),
        ),
        const SizedBox(height: 4),
        Text(
          '* THIS IS AN AUTO-GENERATED LABEL AND DOES NOT NEED ANY SIGNATURE.',
          style: TextStyle(
            fontSize: fontSize - 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}