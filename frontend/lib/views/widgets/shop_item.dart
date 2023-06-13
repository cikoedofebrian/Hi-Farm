import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/controllers/shop_controller.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.image,
    required this.city,
    required this.name,
    required this.id,
    required this.price,
  });

  final int id;
  final String image;
  final String name;
  final int price;
  final String city;

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    return Container(
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
                  image,
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
                      Text(name),
                      Text(
                        'Rp $price',
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
                              city,
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
                InkWell(
                  onTap: () {
                    final selectedProduct = shopController.productList
                        .firstWhere((element) => element.id == id);
                    shopController.addToCart(selectedProduct);
                  },
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
    );
  }
}
