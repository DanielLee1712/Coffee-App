class CartItem {
  final String name;
  final String description;
  final String price;
  final String deliveryFee;
  final String imagePath;
  final String category;
  String size;
  int quantity;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.deliveryFee,
    required this.imagePath,
    required this.category,
    this.size = 'M',
    this.quantity = 1,
  });

  double get priceValue {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double get deliveryFeeValue {
    final cleaned = deliveryFee.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double get unitPrice {
    final base = priceValue;
    if (size == 'S') return base - 2.0;
    if (size == 'L') return base + 2.0;
    return base;
  }

  double get totalPrice {
    return unitPrice * quantity;
  }
}
