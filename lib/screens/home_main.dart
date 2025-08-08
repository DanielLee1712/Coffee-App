import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/providers/home_main_provider.dart';
import 'package:first_ui/providers/cart_provider.dart';
import 'package:first_ui/widgets/home_header.dart';
import 'package:first_ui/widgets/home_title.dart';
import 'package:first_ui/widgets/home_search_bar.dart';
import 'package:first_ui/widgets/home_category_list.dart';
import 'package:first_ui/widgets/home_product_card.dart';
import 'package:first_ui/widgets/home_special_offer.dart';
import 'package:first_ui/widgets/home_bottom_navigation_bar.dart';
import 'package:first_ui/models/cart_item.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Consumer<HomeMainProvider>(
      builder: (context, homeProvider, child) {
        final String selectedCategory = homeProvider.categories[homeProvider.selectedCategoryIndex];
        final List<CartItem> filteredProducts = cartProvider.allAvailableProducts
            .where((item) => item.category == selectedCategory)
            .toList();

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 30),
                  const HomeTitle(),
                  const SizedBox(height: 30),
                  const HomeSearchBar(),
                  const SizedBox(height: 30),
                  HomeCategoryList(),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredProducts.length,
                      itemBuilder: (itemBuilderContext, index) {
                        final product = filteredProducts[index];
                        return HomeProductCard(
                          product: product,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Special for you',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const HomeSpecialOffer(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          bottomNavigationBar: HomeBottomNavigationBar(),
        );
      },
    );
  }
}
