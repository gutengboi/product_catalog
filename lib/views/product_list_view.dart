import 'package:flutter/material.dart';
import '../models/product.dart';
import '../viewmodels/product_viewmodel.dart';
import '../widgets/FilterView.dart';
import '../widgets/product_item_widget.dart';
import 'package:provider/provider.dart';
import 'product_add_edit_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Catalog'),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FilterView(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Consumer<ProductViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.filteredProducts.isEmpty) {
                return const Center(child: CircularProgressIndicator()); // Show a loader while waiting
              } else if (viewModel.filteredProducts.isEmpty) {
                return const Center(child: Text('No products available')); // Show a message if no data
              } else {
                final products = viewModel.filteredProducts;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItemWidget(product: product);
                  },
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProductAddEditView(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

}