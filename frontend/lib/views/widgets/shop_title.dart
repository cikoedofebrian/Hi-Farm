import 'package:flutter/material.dart';
import 'package:hifarm/models/data/shop_model.dart';
import 'package:hifarm/models/page_data/cart_model.dart';
import 'package:hifarm/views/widgets/cart_item.dart';

class ShopTitle extends StatelessWidget {
  const ShopTitle({
    super.key,
    required this.shop,
    required this.products,
  });

  final MShop shop;
  final List<MInsideCart> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shop.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        ...List.generate(
          products.length,
          (index) =>
              CartItem(shopId: shop.id, prodId: products[index].product.id),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
