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
      size: 'M',
    ),
    CartItem(
      name: "Cappuccino đá",
      description: "Delicious creamy iced coffee",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Iced_Cappuccino.jpeg",
      category: "Cappuccino",
      size: 'M',
    ),
    CartItem(
      name: "Cappuccino nóng",
      description: "Delicious hot creamy coffee",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Hot_Cappuccino.jpeg",
      category: "Cappuccino",
      size: 'M',
    ),
    CartItem(
      name: "Latte đá",
      description: "Smooth espresso with chilled milk",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Latte.jpeg",
      category: "Latte",
      size: 'M',
    ),
    CartItem(
      name: "Latte nóng",
      description: "Warm and creamy coffee",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Hot_Latte.jpeg",
      category: "Latte",
      size: 'M',
    ),
    CartItem(
      name: "Espresso đá",
      description: "Strong and refreshing",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Espresso.jpeg",
      category: "Espresso",
      size: 'M',
    ),
    CartItem(
      name: "Espresso nóng",
      description: "Pure concentrated espresso flavor",
      price: "US \$18.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Hot_Latte.jpeg",
      category: "Espresso",
      size: 'M',
    ),
    CartItem(
      name: "Cà phê đen",
      description: "Pure brewed coffee, no milk",
      price: "US \$10.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Black_Coffee.jpeg",
      category: "Espresso",
      size: 'M',
    ),
    CartItem(
      name: "Nâu đá",
      description: "Chilled, creamy, and energizing",
      price: "US \$22.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Milk_Coffee.jpeg",
      category: "Vietnamese Coffee",
      size: 'M',
    ),
    CartItem(
      name: "Nâu nóng",
      description: "Traditional style hot coffee",
      price: "US \$22.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Hot_Milk_Coffee.jpeg",
      category: "Vietnamese Coffee",
      size: 'M',
    ),
    CartItem(
      name: "Cà phê sữa đá",
      description: "Creamy and light style drink",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Iced_Milk_with_a_Splash_of_Coffee.jpeg",
      category: "Latte",
      size: 'M',
    ),
    CartItem(
      name: "Cà phê sữa nóng",
      description: "Creamy, smooth, and lightly caffeinated",
      price: "US \$20.00",
      deliveryFee: "US \$1",
      imagePath: "assets/images/Hot_Milk_with_a_Splash_of_Coffee.jpeg",
      category: "Latte",
      size: 'M',
    ),
    CartItem(
      name: "Americano đá",
      description: "Bold, smooth, and refreshing",
      price: "US \$17.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Iced_Americano.jpeg",
      category: "Americano",
      size: 'M',
    ),
    CartItem(
      name: "Americano nóng",
      description: "Espresso diluted with hot water",
      price: "US \$17.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Hot_Americano.jpeg",
      category: "Americano",
      size: 'M',
    ),
    CartItem(
      name: "Caramel Macchiato đá",
      description: "Sweet, creamy, and refreshing",
      price: "US \$16.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Iced_Caramel_Macchiato.jpeg",
      category: "Latte",
      size: 'M',
    ),
    CartItem(
      name: "Caramel Macchiato nóng",
      description: "Warm, sweet, and creamy",
      price: "US \$16.00",
      deliveryFee: "US \$2",
      imagePath: "assets/images/Hot_Caramel_Macchiato.jpeg",
      category: "Latte",
      size: 'M',
    ),
    CartItem(
      name: "Cold Brew sữa tươi",
      description: "Chilled, mellow, and refreshing",
      price: "US \$24.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Cold_Brew_Milk_Coffee.jpeg",
      category: "Cold Brew",
      size: 'M',
    ),
    CartItem(
      name: "Cold Brew truyền thống",
      description: "Bold, smooth, and naturally sweet",
      price: "US \$24.00",
      deliveryFee: "US \$3",
      imagePath: "assets/images/Black_Cold_Brew.jpeg",
      category: "Cold Brew",
      size: 'M',
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
    return subtotal + totalDeliveryFee;
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
      total += item.totalPrice; // dùng giá theo size
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

  // Thêm vào giỏ theo name + size
  void addToCart(CartItem newItem) {
    final existingItemIndex = _currentCartItems.indexWhere(
      (item) => item.name == newItem.name && item.size == newItem.size,
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
        size: newItem.size,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  // Cập nhật số lượng theo name + size
  void updateCartItemQuantityBySize(
      CartItem itemToUpdate, int newQuantity, String size) {
    final existingItemIndex = _currentCartItems.indexWhere(
      (item) => item.name == itemToUpdate.name && item.size == size,
    );

    if (newQuantity <= 0) {
      if (existingItemIndex != -1) {
        _currentCartItems.removeAt(existingItemIndex);
      }
    } else {
      if (existingItemIndex != -1) {
        _currentCartItems[existingItemIndex].quantity = newQuantity;
      } else {
        _currentCartItems.add(CartItem(
          name: itemToUpdate.name,
          description: itemToUpdate.description,
          price: itemToUpdate.price,
          deliveryFee: itemToUpdate.deliveryFee,
          imagePath: itemToUpdate.imagePath,
          category: itemToUpdate.category,
          size: size,
          quantity: newQuantity,
        ));
      }
    }
    notifyListeners();
  }

  // Giữ lại hàm cũ để không phá chỗ khác (mặc định size M)
  void updateCartItemQuantity(CartItem itemToUpdate, int newQuantity) {
    updateCartItemQuantityBySize(itemToUpdate, newQuantity, 'M');
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

  // Số lượng theo name + size
  int getItemQuantityBySize(String productName, String size) {
    final item = _currentCartItems.firstWhere(
      (item) => item.name == productName && item.size == size,
      orElse: () => CartItem(
        name: '',
        description: '',
        price: '',
        deliveryFee: '',
        imagePath: '',
        category: '',
        size: size,
        quantity: 0,
      ),
    );
    return item.quantity;
  }

  // Tổng số lượng của tất cả size theo name (nếu cần)
  int getItemQuantity(String productName) {
    int total = 0;
    for (var item in _currentCartItems) {
      if (item.name == productName) total += item.quantity;
    }
    return total;
  }

  int getCartItemIndexBySize(String productName, String size) {
    return _currentCartItems.indexWhere(
      (item) => item.name == productName && item.size == size,
    );
  }

  int getCartItemIndex(String productName) {
    return _currentCartItems.indexWhere((item) => item.name == productName);
  }
}
