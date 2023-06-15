import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/shop_model.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/keyword_not_found.dart';

import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/shop_item.dart';

class ShopWithProducts extends StatelessWidget {
  const ShopWithProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final MShop shop = Get.arguments;
    final ShopController shopController = Get.find();
    return Scaffold(
        backgroundColor: AppColor.primary,
        body: FutureBuilder(
            future: shopController.getShopProducts(shop.id),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CustomLoadingIndicator();
              }
              final productsData = snapshot.data!;
              return Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 100, bottom: 20),
                  color: AppColor.secondary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.navigate_before_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shop.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              shop.description,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  shop.address,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const RoundedTopPadding(),
                Text(
                  'Produk',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: productsData.isNotEmpty
                      ? GridView.builder(
                          padding: const EdgeInsets.only(bottom: 120),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 products per row
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: productsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ShopItem(
                              product: productsData[index],
                            );
                          },
                        )
                      : const KeywordNotFound(
                          description:
                              'Produk dengan keyword ini belum tersedia'),
                ),
              ]);
            }));
  }
}
