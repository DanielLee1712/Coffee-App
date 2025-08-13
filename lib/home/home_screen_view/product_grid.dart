import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/cart/json/cart_item.dart';
import 'package:first_ui/home/home_screen_view/product_detail_screen.dart';

class ProductGridSmall extends StatelessWidget {
  final int maxItems;
  final int columns;
  final double crossSpacing;
  final double mainSpacing;
  final double childAspectRatio;

  final double horizontalContentPadding;

  const ProductGridSmall({
    Key? key,
    this.maxItems = 16,
    this.columns = 4,
    this.crossSpacing = 8.0,
    this.mainSpacing = 8.0,
    this.childAspectRatio = 1.00,
    this.horizontalContentPadding = 16.0,
  }) : super(key: key);

  double _calcGridHeight(BuildContext context, int itemCount) {
    final rows = (itemCount / columns).ceil();
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth - horizontalContentPadding * 2;
    final tileWidth = (contentWidth - crossSpacing * (columns - 1)) / columns;
    final tileHeight = tileWidth / childAspectRatio;
    return rows * tileHeight + (rows - 1) * mainSpacing;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, List<CartItem>>(
      selector: (_, p) => p.allAvailableProducts,
      builder: (context, products, _) {
        final count = (products.length > maxItems) ? maxItems : products.length;
        final gridHeight = _calcGridHeight(context, count);

        return SizedBox(
          height: gridHeight,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: crossSpacing,
              mainAxisSpacing: mainSpacing,
            ),
            itemCount: count,
            itemBuilder: (context, index) {
              final product = products[index];
              return _SmallProductTile(product: product);
            },
          ),
        );
      },
    );
  }
}

class _SmallProductTile extends StatelessWidget {
  final CartItem product;
  const _SmallProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
            settings: const RouteSettings(name: '/product_detail'),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: const Color(0xFF8B5E3C),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Image.asset(
                product.imagePath,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image, size: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
