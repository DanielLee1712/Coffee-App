import 'dart:convert';
import 'package:calculator/calculator.dart';

class CartItem {
  final int? id;
  final String name;
  final String description;
  final String price;
  final String deliveryFee;
  final String imagePath;
  final String category;
  String size;
  int quantity;

  CartItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.deliveryFee,
    required this.imagePath,
    required this.category,
    this.size = 'M',
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int?,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      deliveryFee: json['deliveryFee'] ?? '',
      imagePath: json['imagePath'] ?? '',
      category: json['category'] ?? '',
      size: json['size'] ?? 'M',
      quantity: (json['quantity'] ?? 1) is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'name': name,
        'description': description,
        'price': price,
        'deliveryFee': deliveryFee,
        'imagePath': imagePath,
        'category': category,
        'size': size,
        'quantity': quantity,
      };

  static List<CartItem> listFromJsonString(String s) {
    final data = jsonDecode(s) as List;
    return data
        .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  double get priceValue {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double get deliveryFeeValue {
    final cleaned = deliveryFee.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  Future<double> getUnitPrice() async {
    final result = await Calculator.calculate(
      priceValue.toInt(),
      quantity,
      size,
    );
    return (result['unitPrice'] as num).toDouble();
  }

  Future<double> getTotalPrice() async {
    final result = await Calculator.calculate(
      priceValue.toInt(),
      quantity,
      size,
    );
    return (result['totalPrice'] as num).toDouble();
  }

  CartItem copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    String? deliveryFee,
    String? imagePath,
    String? category,
    String? size,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

extension CartItemListJson on CartItem {
  static List<CartItem> listFromJsonString(String s) {
    final data = jsonDecode(s) as List;
    return data
        .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
