import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/keyword_not_found.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/shop_title.dart';

class ViewCart extends StatelessWidget {
  const ViewCart({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 60, bottom: 20),
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
                              "Keranjang",
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const RoundedTopPadding(),
                Obx(() {
                  if (shopController.cart.isEmpty) {
                    return const KeywordNotFound(
                      description:
                          'Tambahkan ke keranjang untuk melakukan transaksi',
                      title: 'Keranjang anda kosong!',
                    );
                  }
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 80),
                      child: Column(
                        children: List.generate(
                            shopController.cart.length,
                            (index) => ShopTitle(
                                shop: shopController.cart[index].shop,
                                products:
                                    shopController.cart[index].productList)),
                      ));
                })
              ]),
            ),
            Obx(
              () => shopController.cart.isNotEmpty
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: InkWell(
                          onTap: () => Get.toNamed(completeOrder),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.secondary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Check Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
