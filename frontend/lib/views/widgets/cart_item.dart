import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/controllers/shop_controller.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.shopId,
    required this.prodId,
  });

  final int shopId;
  final int prodId;

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    final product = shopController.getCartProduct(shopId, prodId);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 120,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  product.product.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.product.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            product.product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.tertiary),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => shopController
                                      .decreaseFromCart(product.product),
                                  child: const Icon(
                                    Icons.remove_rounded,
                                    color: AppColor.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Obx(
                                  () => Text(
                                    shopController
                                        .getCartProduct(shopId, prodId)
                                        .quantity
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () =>
                                      shopController.addToCart(product.product),
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 2,
          color: Colors.black,
        ),
      ],
    );
  }
}
