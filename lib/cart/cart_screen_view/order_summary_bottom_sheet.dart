import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/home/provider/home_main_provider.dart';
import 'package:first_ui/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:style_packet/app_text_styles.dart';

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
                    Text('Shopping cart', style: AppTextStyles.pageTitle.s(20)),
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
                        key: ValueKey(item.name + item.size + index.toString()),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                provider.removeItem(index);
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
                                width: 40,
                                height: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
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
                                    Text('${item.name} • Size ${item.size}',
                                        style: AppTextStyles.bodyStrong.s(13)),
                                    FutureBuilder<double>(
                                      future: item.getUnitPrice(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Text("Đang tính giá...");
                                        }
                                        return Text(
                                          'Price: US \$${snapshot.data!.toStringAsFixed(2)}',
                                        );
                                      },
                                    ),
                                    Text('Delivery fee: ${item.deliveryFee}',
                                        style: AppTextStyles.body
                                            .c(Colors.orange)),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Text('Quantity:'),
                                        Selector<CartProvider, int>(
                                          selector: (_, p) =>
                                              p.cartItems[index].quantity,
                                          builder: (context, quantity, _) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  onPressed: () => provider
                                                      .decreaseQuantity(index),
                                                  icon: const Icon(Icons.remove,
                                                      size: 16),
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 20,
                                                          minHeight: 20),
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
                                                  child: Text('$quantity',
                                                      style: AppTextStyles
                                                          .bodyStrong
                                                          .s(14)),
                                                ),
                                                IconButton(
                                                  onPressed: () => provider
                                                      .increaseQuantity(index),
                                                  icon: const Icon(Icons.add,
                                                      size: 16),
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 20,
                                                          minHeight: 20),
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
                              FutureBuilder<double>(
                                future: item.getTotalPrice(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text("...");
                                  }
                                  return Text(
                                    'US \$${snapshot.data!.toStringAsFixed(2)}',
                                    style: AppTextStyles.bodyStrong
                                        .s(12)
                                        .c(Colors.brown),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Divider(),
                FutureBuilder<double>(
                  future: provider.getSubtotal(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text("Subtotal: ...");
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total price:'),
                        Text('US \$${snapshot.data!.toStringAsFixed(2)}'),
                      ],
                    );
                  },
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
                FutureBuilder<double>(
                  future: provider.getTotalAmount(),
                  builder: (context, snapshot) {
                    final total = snapshot.data ?? 0;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:', style: AppTextStyles.bodyStrong.s(16)),
                        Text('US \$${total.toStringAsFixed(2)}',
                            style:
                                AppTextStyles.bodyStrong.c(Colors.brown).s(16)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: currentCartItems.isEmpty
                        ? null
                        : () async {
                            final total = await provider.getTotalAmount();

                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Confirm order'),
                                content: Text(
                                  'Bạn có chắc muốn đặt ${provider.totalQuantityInCart} món với tổng US \$${total.toStringAsFixed(2)}?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown),
                                    onPressed: () async {
                                      final cartProvider =
                                          context.read<CartProvider>();
                                      final homeProvider =
                                          context.read<HomeMainProvider>();
                                      final rootNav = Navigator.of(context,
                                          rootNavigator: true);
                                      final username = context
                                              .read<LoginProvider>()
                                              .currentUsername ??
                                          'guest';

                                      final billId =
                                          await cartProvider.checkout(username);

                                      if (billId > 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  "Đơn hàng #$billId đã được tạo thành công!")),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "Đã có lỗi xảy ra. Vui lòng thử lại.")),
                                        );
                                      }

                                      homeProvider.setSelectedBottomNavIndex(3);
                                      rootNav.pop();
                                      rootNav.pop();
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
                    child: FutureBuilder<double>(
                      future: provider.getTotalAmount(),
                      builder: (context, snapshot) {
                        final total = snapshot.data ?? 0;
                        return Text(
                          currentCartItems.isEmpty
                              ? 'Không có món nào được chọn'
                              : 'Order - US \$${total.toStringAsFixed(2)}',
                          style: AppTextStyles.bodyStrong.c(Colors.white).s(16),
                        );
                      },
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
