class Product {
  int? id;
  String name;
  String description;
  double price;
  String category;
  String image;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }

  // Convert a Map into a Product
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      image: map['image'],
    );
  }
}
