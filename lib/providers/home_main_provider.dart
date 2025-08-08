import 'package:flutter/material.dart';

class HomeMainProvider extends ChangeNotifier {
  int _selectedCategoryIndex = 0;
  int _selectedBottomNavIndex = 0;

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
}
