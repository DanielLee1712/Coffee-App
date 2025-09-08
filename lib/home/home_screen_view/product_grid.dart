import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_ui/cart/provider/cart_provider.dart';
import 'package:first_ui/cart/models/cart_item.dart';
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
    this.horizontalContentPadding = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<CartProvider>().loadProductsFromDB(),
      builder: (context, snapshot) {
        return Selector<CartProvider, List<CartItem>>(
          selector: (_, p) => p.allAvailableProducts,
          builder: (context, products, _) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                products.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            if (products.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Không có sản phẩm"),
                  ),
                ),
              );
            }

            final count =
                (products.length > maxItems) ? maxItems : products.length;

            return SliverPadding(
              padding:
                  EdgeInsets.symmetric(horizontal: horizontalContentPadding),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: crossSpacing,
                  mainAxisSpacing: mainSpacing,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = products[index];
                    return _SmallProductTile(product: product);
                  },
                  childCount: count,
                ),
              ),
            );
          },
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
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.coffee,
                        size: 40, color: Colors.grey);
                  },
                ),
              ),
            ),
            const SizedBox(height: 3),
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
