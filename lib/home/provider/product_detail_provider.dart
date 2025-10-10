import 'package:flutter/foundation.dart';
import 'package:first_ui/cart/models/cart_item.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';

class ProductDetailProvider extends ChangeNotifier {
  String _selectedChocolate = 'White Chocolate';
  String _selectedSize = 'M';
  int _quantity = 1;

  String get selectedChocolate => _selectedChocolate;
  String get selectedSize => _selectedSize;
  int get quantity => _quantity;

  void selectChocolate(String value) {
    if (_selectedChocolate == value) return;
    _selectedChocolate = value;
    notifyListeners();
  }

  void selectSize(String size, CartProvider cart, CartItem product) {
    if (_selectedSize == size) return;
    _selectedSize = size;

    final q = cart.getItemQuantityBySize(product.name, size);
    _quantity = (q <= 0) ? 1 : q;

    notifyListeners();
  }

  void increaseQuantity() {
    _quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity > 1) {
      _quantity -= 1;
      notifyListeners();
    }
  }

  double unitPriceFor(String basePriceStr) {
    final cleaned = basePriceStr.replaceAll(RegExp(r'[^0-9\.\-]'), '');
    final base = double.tryParse(cleaned) ?? 0.0;

    if (_selectedSize == 'S') return base - 2.0;
    if (_selectedSize == 'L') return base + 2.0;
    return base;
  }
}
