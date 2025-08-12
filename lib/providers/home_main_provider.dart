import 'package:flutter/material.dart';

class HomeMainProvider extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  int _selectedBottomNavIndex = 0;
  bool _isMenuOpen = false; // Added menu state

  final List<String> _categories = [
    'Espresso',
    'Latte',
    'Cappuccino',
    'Americano',
    'Cold Brew',
    'Vietnamese Coffee',
  ];

  int get selectedCategoryIndex => _selectedCategoryIndex;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;
  List<String> get categories => _categories;
  bool get isMenuOpen => _isMenuOpen; // Added getter

  void setSelectedCategoryIndex(int index) {
    if (_selectedCategoryIndex != index) {
      _selectedCategoryIndex = index;
      notifyListeners();
    }
  }

  void setSelectedBottomNavIndex(int index) {
    if (_selectedBottomNavIndex != index) {
      _selectedBottomNavIndex = index;
      notifyListeners();
    }
  }

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  void closeMenu() {
    if (_isMenuOpen) {
      _isMenuOpen = false;
      notifyListeners();
    }
  }
}
