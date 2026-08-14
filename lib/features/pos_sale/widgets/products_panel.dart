import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_snack_bar.dart';
import '../../../mock_data/mock_data.dart';
import '../../../theme/app_theme.dart';
import '../controllers/cart_controller.dart';
import 'product_category_tabs.dart';
import 'product_grid.dart';
import 'products_empty_state.dart';
import 'pos_search_bar.dart';

/// الجزء الأكبر من شاشة الكاشير: البحث + الفئات + شبكة المنتجات.
class ProductsPanel extends StatefulWidget {
  const ProductsPanel({super.key});

  @override
  State<ProductsPanel> createState() => _ProductsPanelState();
}

class _ProductsPanelState extends State<ProductsPanel>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  String _query = '';

  /// null = تبويب "الكل"
  String? get _selectedCategoryId => _tabController.index == 0
      ? null
      : MockData.categories[_tabController.index - 1].id;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: MockData.categories.length + 1,
      vsync: this,
    )..addListener(() {
        if (!_tabController.indexIsChanging) return;
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
    _searchFocus.requestFocus();
  }

  void _addToCart(Product product) {
    final bool added = context.read<CartController>().addProduct(product);
    if (!added) {
      showAppSnackBar(
        context,
        '«${product.name}» غير متوفر في المخزون',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> products = MockData.searchProducts(
      _query,
      categoryId: _selectedCategoryId,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        PosSearchBar(
          controller: _searchController,
          focusNode: _searchFocus,
          query: _query,
          onChanged: (String v) => setState(() => _query = v),
          onClear: _clearSearch,
          onScan: () => showAppSnackBar(context, 'جاهز لمسح الباركود…'),
        ),
        const SizedBox(height: AppSpacing.lg),
        ProductCategoryTabs(controller: _tabController),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: products.isEmpty
              ? const ProductsEmptyState()
              : ProductGrid(products: products, onProductTap: _addToCart),
        ),
      ],
    );
  }
}
