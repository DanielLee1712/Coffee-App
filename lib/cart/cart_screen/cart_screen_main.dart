import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/cart/cart_screen_view/cart_item_widget.dart';
import 'package:first_ui/cart/cart_screen_view/order_summary_bottom_sheet.dart';
import 'package:style_packet/app_text_styles.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
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
                    return Center(
                      child: Text(
                        'Your cart is empty!',
                        style:
                            AppTextStyles.bodySecondary.s(18).c(Colors.black),
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
                        style: AppTextStyles.bodyStrong.s(16).c(Colors.white),
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
    );
  }
}
