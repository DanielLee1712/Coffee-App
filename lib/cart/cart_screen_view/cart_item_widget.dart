import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:style_packet/app_text_styles.dart';

class CartItemWidget extends StatelessWidget {
  final int index;

  const CartItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, int>(
      selector: (_, provider) {
        if (index >= 0 && index < provider.cartItems.length) {
          return provider.cartItems[index].quantity;
        }
        return 0;
      },
      builder: (context, quantity, _) {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        if (index >= cartProvider.cartItems.length) {
          return const SizedBox.shrink();
        }
        final item = cartProvider.cartItems[index];

        return Slidable(
          key: ValueKey(item.name + item.size + index.toString()),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  cartProvider.removeItem(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Đã xóa "${item.name} (Size ${item.size})" khỏi giỏ hàng!'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Xóa',
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [BoxShadow(blurRadius: 10, color: Colors.white)],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                Image.asset(
                  item.imagePath,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: const Icon(Icons.coffee),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.name} • Size ${item.size}',
                          style: AppTextStyles.bodyStrong.s(16)),
                      const SizedBox(height: 4),
                      Text(item.description,
                          style: AppTextStyles.bodySecondary
                              .s(13)
                              .c(Colors.grey[700]!)),
                      const SizedBox(height: 4),
                      Text(
                        'US \$${item.unitPrice.toStringAsFixed(2)}',
                        style: AppTextStyles.bodyStrong.s(16),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text("Delivery fee ${item.deliveryFee}",
                              style: AppTextStyles.body.s(12).c(Colors.orange)),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartProvider.decreaseQuantity(index);
                                },
                                icon: const Icon(Icons.remove, size: 18),
                              ),
                              Text("$quantity"),
                              IconButton(
                                onPressed: () {
                                  cartProvider.increaseQuantity(index);
                                },
                                icon: const Icon(Icons.add, size: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
