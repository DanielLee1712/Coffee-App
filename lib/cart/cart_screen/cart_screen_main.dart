import 'package:first_ui/home/home_screen_view/home_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/cart/cart_screen_view/cart_item_widget.dart';
import 'package:first_ui/cart/cart_screen_view/order_summary_bottom_sheet.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Provider.of<HomeMainProvider>(context, listen: false)
                .setSelectedBottomNavIndex(0);
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: [
            Consumer<CartProvider>(
              builder: (context, provider, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Items(${provider.distinctItemCount})',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, provider, child) {
                  final cartItems = provider.cartItems;
                  if (cartItems.isEmpty) {
                    return const Center(
                      child: Text(
                        'Your cart is empty!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(index: index);
                    },
                  );
                },
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, provider, _) {
                if (provider.distinctItemCount > 0) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: () => showOrderSummaryBottomSheet(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Shopping cart (${provider.totalQuantityInCart} Items) - US \$${provider.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavItem(
              icon: Icons.home,
              index: 0,
              currentIndex: 2,
              onTap: (idx) {
                if (idx == 0) {
                  Provider.of<HomeMainProvider>(context, listen: false)
                      .setSelectedBottomNavIndex(0);
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
            ),
            BottomNavItem(
              icon: Icons.favorite_border,
              index: 1,
              currentIndex: 2,
              onTap: (idx) {},
            ),
            BottomNavItem(
              icon: Icons.shopping_bag_outlined,
              index: 2,
              currentIndex: 2,
              onTap: (idx) {},
            ),
            BottomNavItem(
              icon: Icons.notifications_outlined,
              index: 3,
              currentIndex: 2,
              onTap: (idx) {},
            ),
            BottomNavItem(
              icon: Icons.person_outline,
              index: 4,
              currentIndex: 2,
              onTap: (idx) {},
            ),
          ],
        ),
      ),
    );
  }
}
