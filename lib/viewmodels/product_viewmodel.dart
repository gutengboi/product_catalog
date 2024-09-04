import 'package:flutter/material.dart';
import 'package:product_catalog_app/services/product_service.dart';
import '../models/product.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  List<Product> get products => _filteredProducts;

  ProductService db = ProductService();

  void loadProducts(List<Product> products) {
    _allProducts = products;
    _filteredProducts = products;
    var dbItem =  db.products();
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
    db.insertProduct(product);
    _filteredProducts.add(product);
    notifyListeners();
  }

  void updateProduct(Product updatedProduct) {
    final index = _allProducts.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _allProducts[index] = updatedProduct;
      _filteredProducts[index] = updatedProduct;
      db.updateProduct(updatedProduct) ;
      notifyListeners();
    }
  }

  void deleteProduct(int productId) {
    _allProducts.removeWhere((product) => product.id == productId);
    _filteredProducts.removeWhere((product) => product.id == productId);
    //db.deleteProduct(id)
    notifyListeners();
  }
}
