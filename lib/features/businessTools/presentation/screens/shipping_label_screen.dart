import 'package:flutter/material.dart';
import 'package:sharkship/features/businessTools/presentation/widgets/shipping_label.dart';

class ShippingLabelDemoPage extends StatefulWidget {
  const ShippingLabelDemoPage({Key? key}) : super(key: key);

  @override
  State<ShippingLabelDemoPage> createState() => _ShippingLabelDemoPageState();
}

class _ShippingLabelDemoPageState extends State<ShippingLabelDemoPage> {
  // Controller for label visibility states
  late EnhancedShippingLabelController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = EnhancedShippingLabelController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Label'),
        elevation: 1,
        actions: isMobile
            ? [
                IconButton(
                  icon: Icon(
                    _showControls
                        ? Icons.unfold_less_double
                        : Icons.unfold_more_double,
                  ),
                  tooltip: _showControls ? 'Hide Controls' : 'Show Controls',
                  onPressed: () {
                    setState(() {
                      _showControls = !_showControls;
                    });
                  },
                ),
              ]
            : null,
      ),
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  /// Mobile layout: Controls on top (collapsible), Label below
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Controls Section (Collapsible)
        if (_showControls)
          Expanded(
            flex: 0,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[50],
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Label Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    _buildControlsGrid(),
                  ],
                ),
              ),
            ),
          ),

        // Divider
        Container(height: 1, color: Colors.grey[300]),

        // Shipping Label Section (Scrollable)
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return ShippingLabel(controller: _controller);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Desktop layout: Controls on top, Label below (responsive)
  Widget _buildDesktopLayout() {
    return Column(
      children: [
        // Controls Section
        Container(
          color: Colors.grey[50],
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Label Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _buildControlsGrid(),
            ],
          ),
        ),

        // Divider
        Container(height: 1, color: Colors.grey[300]),

        // Shipping Label Section
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return ShippingLabel(controller: _controller);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Reusable controls grid - responsive columns
  Widget _buildControlsGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final columns = isMobile ? 1 : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header Settings
        _buildSection(
          title: 'Header Settings',
          items: [
            _buildToggleItem('Logo Visibility', _controller.logoVisibility, (
              val,
            ) {
              setState(() => _controller.logoVisibility = val);
            }),
            _buildToggleItem('Phone Visibility', _controller.phoneVisibility, (
              val,
            ) {
              setState(() => _controller.phoneVisibility = val);
            }),
            _buildToggleItem('Use Custom Name', _controller.alterName, (val) {
              setState(() => _controller.alterName = val);
            }),
          ],
          columns: columns,
        ),

        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),

        // Prepaid Settings
        _buildSection(
          title: 'Prepaid Settings',
          items: [
            _buildToggleItem('Amount Visible', _controller.isAmountVisible, (
              val,
            ) {
              setState(() => _controller.isAmountVisible = val);
            }),
            _buildToggleItem(
              'Client Visibility',
              _controller.clientVisibility,
              (val) {
                setState(() => _controller.clientVisibility = val);
              },
            ),
          ],
          columns: columns,
        ),

        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),

        // Table Settings
        _buildSection(
          title: 'Table Settings',
          items: [
            _buildToggleItem('Table Visibility', _controller.tableVisibility, (
              val,
            ) {
              setState(() => _controller.tableVisibility = val);
            }),
            _buildToggleItem('SKU Visibility', _controller.skuVisibility, (
              val,
            ) {
              setState(() => _controller.skuVisibility = val);
            }),
          ],
          columns: columns,
        ),

        const SizedBox(height: 8),
        const Divider(),
        const SizedBox(height: 8),

        // Footer Settings
        _buildSection(
          title: 'Footer Settings',
          items: [
            _buildToggleItem('RTO Visibility', _controller.rtoVisibility, (
              val,
            ) {
              setState(() => _controller.rtoVisibility = val);
            }),
            _buildToggleItem(
              'RTO Phone Visibility',
              _controller.rtoPhoneVisibility,
              (val) {
                setState(() => _controller.rtoPhoneVisibility = val);
              },
            ),
            _buildToggleItem('GST Visibility', _controller.gstVisibility, (
              val,
            ) {
              setState(() => _controller.gstVisibility = val);
            }),
            _buildToggleItem(
              'Sharkship Visibility',
              _controller.sharkshipVisibility,
              (val) {
                setState(() => _controller.sharkshipVisibility = val);
              },
            ),
          ],
          columns: columns,
        ),

        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),

        // Business Name Input
        Text('Business Name', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          controller: _controller.newNameController,
          decoration: InputDecoration(
            labelText: 'Enter business name',
            hintText: 'business name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            prefixIcon: const Icon(Icons.business),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  /// Section builder for grouped settings
  Widget _buildSection({
    required String title,
    required List<Widget> items,
    required int columns,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 4, children: items),
      ],
    );
  }

  /// Reusable toggle item widget
  Widget _buildToggleItem(String label, bool value, Function(bool) onChanged) {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}

/// Enhanced Controller with reactive state
class EnhancedShippingLabelController extends ShippingLabelController
    with ChangeNotifier {
  bool _logoVisibility = true;
  bool _phoneVisibility = false;
  bool _isAmountVisible = true;
  bool _clientVisibility = false;
  bool _tableVisibility = true;
  bool _skuVisibility = true;
  bool _rtoVisibility = true;
  bool _rtoPhoneVisibility = true;
  bool _gstVisibility = true;
  bool _sharkshipVisibility = true;
  bool _alterName = false;

  bool get logoVisibility => _logoVisibility;
  set logoVisibility(bool value) {
    if (_logoVisibility != value) {
      _logoVisibility = value;
      notifyListeners();
    }
  }

  bool get phoneVisibility => _phoneVisibility;
  set phoneVisibility(bool value) {
    if (_phoneVisibility != value) {
      _phoneVisibility = value;
      notifyListeners();
    }
  }

  bool get isAmountVisible => _isAmountVisible;
  set isAmountVisible(bool value) {
    if (_isAmountVisible != value) {
      _isAmountVisible = value;
      notifyListeners();
    }
  }

  bool get clientVisibility => _clientVisibility;
  set clientVisibility(bool value) {
    if (_clientVisibility != value) {
      _clientVisibility = value;
      notifyListeners();
    }
  }

  bool get tableVisibility => _tableVisibility;
  set tableVisibility(bool value) {
    if (_tableVisibility != value) {
      _tableVisibility = value;
      notifyListeners();
    }
  }

  bool get skuVisibility => _skuVisibility;
  set skuVisibility(bool value) {
    if (_skuVisibility != value) {
      _skuVisibility = value;
      notifyListeners();
    }
  }

  bool get rtoVisibility => _rtoVisibility;
  set rtoVisibility(bool value) {
    if (_rtoVisibility != value) {
      _rtoVisibility = value;
      notifyListeners();
    }
  }

  bool get rtoPhoneVisibility => _rtoPhoneVisibility;
  set rtoPhoneVisibility(bool value) {
    if (_rtoPhoneVisibility != value) {
      _rtoPhoneVisibility = value;
      notifyListeners();
    }
  }

  bool get gstVisibility => _gstVisibility;
  set gstVisibility(bool value) {
    if (_gstVisibility != value) {
      _gstVisibility = value;
      notifyListeners();
    }
  }

  bool get sharkshipVisibility => _sharkshipVisibility;
  set sharkshipVisibility(bool value) {
    if (_sharkshipVisibility != value) {
      _sharkshipVisibility = value;
      notifyListeners();
    }
  }

  bool get alterName => _alterName;
  set alterName(bool value) {
    if (_alterName != value) {
      _alterName = value;
      notifyListeners();
    }
  }
}
