import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/product_model.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.product,
    // required this.city,
    // required this.name,
    // required this.id,
    // required this.price,
  });
  final MProduct product;
  // final int id;
  // final String image;
  // final String name;
  // final int price;
  // final String city;

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    return InkWell(
      onTap: () => Get.toNamed(productView, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 4)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name),
                        Text(
                          'Rp ${product.price}',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Text(
                                product.shop!.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (shopController.shop == null ||
                      shopController.shop!.id != product.shop!.id)
                    InkWell(
                      onTap: () => shopController.addToCart(product),
                      child: Material(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.tertiary,
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
