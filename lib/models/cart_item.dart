class CartItem {
  final String name;
  final String description;
  // Giá hiển thị gốc (giá M)
  final String price;
  final String deliveryFee;
  final String imagePath;
  final String category;
  String size; // S, M, L
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

  // Parse giá dạng "US $15.00" an toàn
  double get priceValue {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  double get deliveryFeeValue {
    final cleaned = deliveryFee.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  // Giá đơn vị theo size
  double get unitPrice {
    final base = priceValue;
    if (size == 'S') return base - 2.0;
    if (size == 'L') return base + 2.0;
    return base; // M
  }

  // Thành tiền theo size
  double get totalPrice {
    return unitPrice * quantity;
  }
}
