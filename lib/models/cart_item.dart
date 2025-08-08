import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String description;
  final String price;
  final String deliveryFee;
  final String imagePath;
  final String category; // Added category property
  // Removed isSelected as all items in cart are now implicitly selected
  int quantity;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.deliveryFee,
    required this.imagePath,
    required this.category,
    this.quantity = 1,
  });

  double get priceValue {
    return double.parse(price.replaceAll('US \$', ''));
  }

  double get deliveryFeeValue {
    return double.parse(deliveryFee.replaceAll('US \$', ''));
  }

  double get totalPrice {
    return (priceValue * quantity) + deliveryFeeValue;
  }
}
