import 'dart:convert';
import 'package:first_ui/database/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:first_ui/cart/models/cart_item.dart';
import 'package:sqflite/sqflite.dart';

class CartProvider extends ChangeNotifier {
  String _owner = 'guest';
  void setOwner(String? username) {
    _owner = (username == null || username.isEmpty) ? 'guest' : username;
  }

  String get owner => _owner;

  List<CartItem> _allProducts = [];
  List<CartItem> get allAvailableProducts => _allProducts;

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

  double get subtotal {
    double total = 0.0;
    for (var item in _currentCartItems) {
      total += item.totalPrice;
    }
    return total;
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

  double get totalAmount => subtotal + totalDeliveryFee;

  Future<void> loadProductsFromDB() async {
    final db = await DatabaseHelper.database();
    final data = await db.query('products');

    _allProducts = data.map((row) {
      return CartItem(
        id: row['id'] as int,
        name: row['name'] as String,
        description: row['description'] as String,
        price: row['price'].toString(),
        deliveryFee: row['deliveryFee']?.toString() ?? '0',
        imagePath: row['imagePath'] as String? ?? '',
        category: row['category'] as String? ?? '',
        size: row['size'] as String? ?? 'M',
        quantity: row['quantity'] as int? ?? 1,
      );
    }).toList();

    notifyListeners();
  }

  Future<void> loadCartFromDB() async {
    final db = await DatabaseHelper.database();
    final data = await db.query('cart');
    _currentCartItems.clear();

    for (var row in data) {
      final product = await db.query(
        'products',
        where: 'id = ?',
        whereArgs: [row['productId']],
        limit: 1,
      );
      if (product.isNotEmpty) {
        final p = CartItem.fromJson(product.first);
        p.quantity = row['quantity'] as int;
        p.size = row['size'] as String? ?? 'M';
        _currentCartItems.add(p);
      }
    }
    notifyListeners();
  }

  Future<void> increaseQuantity(int index) async {
    if (index >= 0 && index < _currentCartItems.length) {
      _currentCartItems[index].quantity++;

      final db = await DatabaseHelper.database();
      await db.update(
        'cart',
        {'quantity': _currentCartItems[index].quantity},
        where: 'productId = ? AND size = ?',
        whereArgs: [_currentCartItems[index].id, _currentCartItems[index].size],
      );

      notifyListeners();
    }
  }

  Future<void> decreaseQuantity(int index) async {
    if (index >= 0 && index < _currentCartItems.length) {
      _currentCartItems[index].quantity--;

      final db = await DatabaseHelper.database();
      if (_currentCartItems[index].quantity <= 0) {
        await db.delete(
          'cart',
          where: 'productId = ? AND size = ?',
          whereArgs: [
            _currentCartItems[index].id,
            _currentCartItems[index].size
          ],
        );
        _currentCartItems.removeAt(index);
      } else {
        await db.update(
          'cart',
          {'quantity': _currentCartItems[index].quantity},
          where: 'productId = ? AND size = ?',
          whereArgs: [
            _currentCartItems[index].id,
            _currentCartItems[index].size
          ],
        );
      }

      notifyListeners();
    }
  }

  Future<void> addToCart(CartItem newItem) async {
    final db = await DatabaseHelper.database();

    final existing = await db.query(
      'cart',
      where: 'productId = ? AND size = ?',
      whereArgs: [newItem.id, newItem.size],
    );

    if (existing.isNotEmpty) {
      final index = _currentCartItems.indexWhere(
        (item) => item.id == newItem.id && item.size == newItem.size,
      );
      if (index != -1) {
        _currentCartItems[index].quantity++;
      }
      await db.update(
        'cart',
        {'quantity': _currentCartItems[index].quantity},
        where: 'id = ?',
        whereArgs: [existing.first['id']],
      );
    } else {
      final id = await db.insert('cart', {
        'productId': newItem.id,
        'size': newItem.size,
        'quantity': 1,
      });
      _currentCartItems.add(newItem.copyWith(quantity: 1));
    }
    notifyListeners();
  }

  Future<void> updateCartItemQuantityBySize(
      CartItem itemToUpdate, int newQuantity, String size) async {
    final db = await DatabaseHelper.database();

    if (newQuantity <= 0) {
      await db.delete(
        'cart',
        where: 'productId = ? AND size = ?',
        whereArgs: [itemToUpdate.id, size],
      );
      _currentCartItems.removeWhere(
          (item) => item.id == itemToUpdate.id && item.size == size);
    } else {
      final index = _currentCartItems.indexWhere(
        (item) => item.id == itemToUpdate.id && item.size == size,
      );
      if (index != -1) {
        _currentCartItems[index].quantity = newQuantity;
      } else {
        _currentCartItems.add(itemToUpdate.copyWith(
          size: size,
          quantity: newQuantity,
        ));
      }

      await db.insert(
        'cart',
        {
          'productId': itemToUpdate.id,
          'size': size,
          'quantity': newQuantity,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    notifyListeners();
  }

  Future<void> updateCartItemQuantity(
      CartItem itemToUpdate, int newQuantity) async {
    await updateCartItemQuantityBySize(itemToUpdate, newQuantity, 'M');
  }

  Future<void> removeItem(int index) async {
    if (index >= 0 && index < _currentCartItems.length) {
      final db = await DatabaseHelper.database();
      await db.delete(
        'cart',
        where: 'productId = ? AND size = ?',
        whereArgs: [_currentCartItems[index].id, _currentCartItems[index].size],
      );
      _currentCartItems.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> resetAfterOrder() async {
    final db = await DatabaseHelper.database();
    await db.delete('cart');
    _currentCartItems.clear();
    notifyListeners();
  }

  int getItemQuantityBySize(String productName, String size) {
    final item = _currentCartItems.firstWhere(
      (item) => item.name == productName && item.size == size,
      orElse: () => CartItem(
        id: -1,
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

  Future<void> loadProductsFromAssets(String assetPath) async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final data = jsonDecode(raw) as List;
      _allProducts
        ..clear()
        ..addAll(data.map((e) => CartItem.fromJson(e as Map<String, dynamic>)));

      final db = await DatabaseHelper.database();
      for (final p in _allProducts) {
        await db.insert('products', p.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('CartProvider.loadProductsFromAssets error: $e');
    }
  }

  Future<int> checkout(String username) async {
    setOwner(username);

    if (_currentCartItems.isEmpty) return -1;

    final db = await DatabaseHelper.database();
    final batch = db.batch();
    final createdAt = DateTime.now().toIso8601String();

    batch.insert('bills', {
      'createdAt': createdAt,
      'total': totalAmount,
      'username': _owner,
    });

    await batch.commit(noResult: true);
    final billRow = await db.query('bills',
        where: 'username = ?',
        whereArgs: [_owner],
        orderBy: 'id DESC',
        limit: 1);
    if (billRow.isEmpty) return -1;
    final billId = billRow.first['id'] as int;

    for (final item in _currentCartItems) {
      await db.insert('bill_details', {
        'billId': billId,
        'productId': item.id,
        'quantity': item.quantity,
        'price': item.unitPrice,
      });
    }

    final msg =
        'Đơn #$billId • ${_currentCartItems.length} món • US \$${totalAmount.toStringAsFixed(2)}';
    await db.insert('notifications', {
      'billId': billId,
      'message': msg,
      'createdAt': createdAt,
      'username': _owner,
    });

    await resetAfterOrder();

    return billId;
  }
}
