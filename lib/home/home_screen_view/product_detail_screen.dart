import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/cart/models/cart_item.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/home/provider/product_detail_provider.dart';
import 'package:style_packet/app_text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final CartItem product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final List<String> _chocolateChoices = [
    'White Chocolate',
    'Milk Chocolate',
    'Dark Chocolate',
  ];

  double _unitPriceForSize(String selectedSize) {
    final base = widget.product.priceValue;
    if (selectedSize == 'S') return base - 2.0;
    if (selectedSize == 'L') return base + 2.0;
    return base;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final detailProvider = context.watch<ProductDetailProvider>();

    final unitPrice = _unitPriceForSize(detailProvider.selectedSize);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.product.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Text(
                        widget.product.name,
                        style: AppTextStyles.pageTitle.s(28),
                      ),
                      Text(
                        widget.product.description,
                        style: AppTextStyles.bodySecondary.s(16),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            '4.8',
                            style: AppTextStyles.bodyStrong.s(16),
                          ),
                          Text(
                            ' (6,900)',
                            style: AppTextStyles.bodySecondary.s(14),
                          ),
                          const Spacer(),
                          _buildInfoChip(Icons.coffee_outlined, 'Coffee'),
                          const SizedBox(width: 10),
                          _buildInfoChip(
                              Icons.water_drop_outlined, 'Chocolate'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Medium Roasted',
                        style: AppTextStyles.bodySecondary.s(14),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Description',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.product.description,
                        style: AppTextStyles.body.s(16).copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Choice of Chocolate',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _chocolateChoices.length,
                          itemBuilder: (context, index) {
                            final choice = _chocolateChoices[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: _buildChoiceButton(
                                choice,
                                detailProvider.selectedChocolate == choice,
                                (value) {
                                  context
                                      .read<ProductDetailProvider>()
                                      .selectChocolate(value);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Size',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildSizeButton(
                            'S',
                            detailProvider.selectedSize == 'S',
                            (value) {
                              context.read<ProductDetailProvider>().selectSize(
                                  value, cartProvider, widget.product);
                            },
                          ),
                          const SizedBox(width: 10),
                          _buildSizeButton(
                            'M',
                            detailProvider.selectedSize == 'M',
                            (value) {
                              context.read<ProductDetailProvider>().selectSize(
                                  value, cartProvider, widget.product);
                            },
                          ),
                          const SizedBox(width: 10),
                          _buildSizeButton(
                            'L',
                            detailProvider.selectedSize == 'L',
                            (value) {
                              context.read<ProductDetailProvider>().selectSize(
                                  value, cartProvider, widget.product);
                            },
                          ),
                          const Spacer(),
                          _buildQuantityButton(Icons.remove, () {
                            context
                                .read<ProductDetailProvider>()
                                .decreaseQuantity();
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              '${detailProvider.quantity}',
                              style: AppTextStyles.bodyStrong.s(20),
                            ),
                          ),
                          _buildQuantityButton(Icons.add, () {
                            context
                                .read<ProductDetailProvider>()
                                .increaseQuantity();
                          }),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: AppTextStyles.price.s(18),
                              ),
                              Text(
                                'US \$${(unitPrice * detailProvider.quantity).toStringAsFixed(2)}',
                                style:
                                    AppTextStyles.price.s(28).c(Colors.black),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              cartProvider.updateCartItemQuantityBySize(
                                widget.product,
                                detailProvider.quantity,
                                detailProvider.selectedSize,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Đã thêm ${detailProvider.quantity} ${widget.product.name} (Size ${detailProvider.selectedSize}) vào giỏ hàng!',
                                  ),
                                  backgroundColor: const Color(0xFFB8860B),
                                  duration: const Duration(seconds: 2),
                                ),
                              );

                              Navigator.pop(context, true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB8860B),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown, size: 18),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceButton(
    String text,
    bool isSelected,
    ValueChanged<String> onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB8860B) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButton(
    String text,
    bool isSelected,
    ValueChanged<String> onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap(text),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB8860B) : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }
}
