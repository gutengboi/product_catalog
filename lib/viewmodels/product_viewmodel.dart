import 'package:flutter/material.dart';
import 'package:product_catalog_app/services/product_service.dart';
import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _filteredProducts = [];


  List<Product> get filteredProducts => _filteredProducts;

  Future<void> loadProducts() async {
    _filteredProducts = await ProductService.db.products();
    notifyListeners();
  }



  Future<void> filterProducts(String? category, double? minPrice, double? maxPrice) async {
    final products = await ProductService.db.products();
    _filteredProducts = products.where((product) {
      final matchesCategory = category == null || category == 'All' || product.category == category;
      final matchesMinPrice = minPrice == null || product.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || product.price <= maxPrice;
      return matchesCategory && matchesMinPrice && matchesMaxPrice;
    }).toList();
    notifyListeners();
  }

  void addProduct(Product product) {
    ProductService.db.insertProduct(product);
    loadProducts();
    notifyListeners();
  }




  Future<void> updateProduct(Product updatedProduct) async {
    try {
      await ProductService.db.updateProduct(updatedProduct);
      loadProducts();
      notifyListeners();
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      await ProductService.db.deleteProduct(productId);
      loadProducts();
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

}