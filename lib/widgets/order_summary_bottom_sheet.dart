import 'package:first_ui/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void showOrderSummaryBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Consumer<CartProvider>(
        builder: (context, provider, _) {
          final currentCartItems = provider.cartItems;
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shopping cart',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentCartItems.length,
                    itemBuilder: (context, index) {
                      final item = currentCartItems[index];
                      return Slidable(
                        key: ValueKey(item.name + index.toString()),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                provider.removeItem(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Đã xóa "${item.name}" khỏi giỏ hàng!'),
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
                          margin: const EdgeInsets.only(bottom: 12.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                item.imagePath,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.coffee),
                                  );
                                },
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.0)),
                                    Text('Price: ${item.price}'),
                                    Text('Delivery fee: ${item.deliveryFee}',
                                        style: const TextStyle(
                                            color: Colors.orange)),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Text('Quantity: '),
                                        Selector<CartProvider, int>(
                                          selector: (_, provider) => provider
                                              .cartItems[index].quantity,
                                          builder: (context, quantity, _) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    provider.decreaseQuantity(
                                                        index);
                                                  },
                                                  icon: const Icon(Icons.remove,
                                                      size: 16),
                                                  constraints:
                                                      const BoxConstraints(
                                                    minWidth: 28,
                                                    minHeight: 28,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.grey[300]!),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    "$quantity",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    provider.increaseQuantity(
                                                        index);
                                                  },
                                                  icon: const Icon(Icons.add,
                                                      size: 16),
                                                  constraints:
                                                      const BoxConstraints(
                                                    minWidth: 28,
                                                    minHeight: 28,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${(item.priceValue * item.quantity).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.brown),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total price:'),
                    Text('US \$${provider.subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total delivery fee:'),
                    Text('US \$${provider.totalDeliveryFee.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.orange)),
                  ],
                ),
                const Divider(thickness: 2.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('US \$${provider.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.brown)),
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: currentCartItems.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Confirm order'),
                                content: Text(
                                    'Bạn có chắc muốn đặt ${provider.totalQuantityInCart} món với tổng US \$${provider.totalAmount.toStringAsFixed(2)}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      provider.resetAfterOrder();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Row(
                                          children: [
                                            Icon(Icons.check_circle,
                                                color: Colors.white),
                                            SizedBox(width: 8),
                                            Text('Order confirmed'),
                                          ],
                                        ),
                                      ));
                                    },
                                    child: const Text('Confirm',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          currentCartItems.isEmpty ? Colors.grey : Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      currentCartItems.isEmpty
                          ? 'Không có món nào được chọn'
                          : 'Order - US \$${provider.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
