import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _allProducts = []; // All products loaded from the database
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;

  void loadProducts(List<Product> products) {
    _allProducts = products;
    _filteredProducts = products;
    notifyListeners();
  }

  void filterProducts(String? category, double? minPrice, double? maxPrice) {
    _filteredProducts = _allProducts.where((product) {
      final matchesCategory = category == null || category == 'All' || product.category == category;
      final matchesMinPrice = minPrice == null || product.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || product.price <= maxPrice;
      return matchesCategory && matchesMinPrice && matchesMaxPrice;
    }).toList();
    notifyListeners();
  }

  void addProduct(Product product) {
    _allProducts.add(product);
    _filteredProducts.add(product);
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    final index = _allProducts.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _allProducts[index] = updatedProduct;
      _filteredProducts[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(int productId) {
    _allProducts.removeWhere((product) => product.id == productId);
    _filteredProducts.removeWhere((product) => product.id == productId);
    notifyListeners();
  }
}
