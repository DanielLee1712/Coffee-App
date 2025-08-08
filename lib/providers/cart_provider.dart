import 'package:flutter/material.dart';
import 'package:first_ui/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _allProducts = [
    CartItem(
      name: "Dalgona Coffee",
      description: "Whipped creamy coffee",
      price: "US \$15.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Dalgona_Coffee.jpeg",
      category: "Espresso",
    ),
    CartItem(
      name: "Iced Cappuccino",
      description: "Delicious creamy iced coffee",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Iced_Cappuccino.jpeg",
      category: "Cappuccino",
    ),
    CartItem(
      name: "Hot Cappuccino",
      description: "Delicious hot creamy coffee",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Hot_Cappuccino.jpeg",
      category: "Cappuccino",
    ),
    CartItem(
      name: "Iced Latte",
      description: "Smooth espresso with chilled milk",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Latte.jpeg",
      category: "Latte",
    ),
    CartItem(
      name: "Hot Latte",
      description: "Warm and creamy coffee",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Hot_Latte.jpeg",
      category: "Latte",
    ),
    CartItem(
      name: "Iced Espresso",
      description: "Strong and refreshing",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Espresso.jpeg",
      category: "Espresso",
    ),
    CartItem(
      name: "Hot Espresso",
      description: "Pure concentrated espresso flavor",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Hot_Latte.jpeg",
      category: "Espresso",
    ),
    CartItem(
      name: "Black Coffee",
      description: "Pure brewed coffee, no milk",
      price: "US \$10.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Black_Coffee.jpeg",
      category: "Espresso",
    ),
    CartItem(
      name: "Vietnamese Iced Milk Coffee",
      description: "Chilled, creamy, and energizing",
      price: "US \$22.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Vietnamese_Iced_Milk_Coffee.jpeg",
      category: "Vietnamese Coffee",
    ),
    CartItem(
      name: "Vietnamese Hot Milk Coffee",
      description: "Traditional Vietnamese-style hot coffee",
      price: "US \$22.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Vietnamese_Hot_Milk_Coffee.jpeg",
      category: "Vietnamese Coffee",
    ),
    CartItem(
      name: "Iced Milk with a Splash of Coffee",
      description: "Creamy and light Vietnamese-style drink",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Iced_Milk_with_a_Splash_of_Coffee.jpeg",
      category: "Latte",
    ),
    CartItem(
      name: "Hot Milk with a Splash of Coffee",
      description: "Creamy, smooth, and lightly caffeinated",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Hot_Milk_with_a_Splash_of_Coffee.jpeg",
      category: "Latte",
    ),
    CartItem(
      name: "Iced Americano",
      description: "Bold, smooth, and refreshing",
      price: "US \$17.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Americano.jpeg",
      category: "Americano",
    ),
    CartItem(
      name: "Hot Americano",
      description: "Espresso diluted with hot water",
      price: "US \$17.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Hot_Americano.jpeg",
      category: "Americano",
    ),
    CartItem(
      name: "Iced Caramel Macchiato",
      description: "Sweet, creamy, and refreshing",
      price: "US \$16.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Iced_Caramel_Macchiato.jpeg",
      category: "Latte",
    ),
    CartItem(
      name: "Hot Caramel Macchiato",
      description: "Warm, sweet, and creamy",
      price: "US \$16.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Hot_Caramel_Macchiato.jpeg",
      category: "Latte",
    ),
    CartItem(
      name: "Cold Brew Milk Coffee",
      description: "Chilled, mellow, and refreshing",
      price: "US \$24.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Cold_Brew_Milk_Coffee.jpeg",
      category: "Cold Brew",
    ),
    CartItem(
      name: "Black Cold Brew",
      description: "Bold, smooth, and naturally sweet",
      price: "US \$24.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Black_Cold_Brew.jpeg",
      category: "Cold Brew",
    ),
  ];

  final List<CartItem> _currentCartItems = [];

  List<CartItem> get cartItems => _currentCartItems;

  int get distinctItemCount => _currentCartItems.length;

  int get totalQuantityInCart {
    int total = 0;
    for (var item in _currentCartItems) {
      total += item.quantity;
    }
    return total;
  }

  double get totalAmount {
    double total = 0.0;
    for (var item in _currentCartItems) {
      total += item.totalPrice;
    }
    return total + totalDeliveryFee;
  }

  double get totalDeliveryFee {
    if (_currentCartItems.isEmpty) return 0.0;
    double maxDeliveryFee = 0.0;
    for (var item in _currentCartItems) {
      if (item.deliveryFeeValue > maxDeliveryFee) {
        maxDeliveryFee = item.deliveryFeeValue;
      }
    }
    return maxDeliveryFee;
  }

  double get subtotal {
    double total = 0.0;
    for (var item in _currentCartItems) {
      total += (item.priceValue * item.quantity);
    }
    return total;
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _currentCartItems.length) {
      _currentCartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _currentCartItems.length) {
      _currentCartItems[index].quantity--;
      if (_currentCartItems[index].quantity <= 0) {
        _currentCartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void addToCart(CartItem newItem) {
    final existingItemIndex = _currentCartItems.indexWhere(
      (item) => item.name == newItem.name,
    );

    if (existingItemIndex != -1) {
      _currentCartItems[existingItemIndex].quantity++;
    } else {
      _currentCartItems.add(CartItem(
        name: newItem.name,
        description: newItem.description,
        price: newItem.price,
        deliveryFee: newItem.deliveryFee,
        imagePath: newItem.imagePath,
        category: newItem.category,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _currentCartItems.length) {
      _currentCartItems.removeAt(index);
      notifyListeners();
    }
  }

  void resetAfterOrder() {
    _currentCartItems.clear();
    notifyListeners();
  }

  List<CartItem> get allAvailableProducts => _allProducts;

  int getItemQuantity(String productName) {
    final item = _currentCartItems.firstWhere(
      (item) => item.name == productName,
      orElse: () => CartItem(
        name: '',
        description: '',
        price: '',
        deliveryFee: '',
        imagePath: '',
        category: '',
        quantity: 0,
      ),
    );
    return item.quantity;
  }

  int getCartItemIndex(String productName) {
    return _currentCartItems.indexWhere((item) => item.name == productName);
  }
}
