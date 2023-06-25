import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/product_model.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final MProduct product = Get.arguments;
    final ShopController shopController = Get.find();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.16,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 20),
                    color: AppColor.secondary,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.navigate_before_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  const RoundedTopPadding(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LayoutBuilder(
                          builder: (context, constraints) => SizedBox(
                            height: constraints.maxWidth,
                            width: constraints.maxWidth,
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "Rp ${product.price}",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Deskripsi',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Penjual',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.secondary,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () => Get.toNamed(estimationTime,
                                      arguments: product.shop!.loc),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.local_shipping,
                                        color: AppColor.secondary,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Lihat estimasi pengiriman',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: AppColor.secondary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(shopWithProducts,
                                    arguments: product.shop!),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 5,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.shop!.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                  ),
                                            ),
                                            const SizedBox(
                                              height: 5,
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
                                                  product.shop!.address,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.navigate_next_rounded,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (shopController.shop == null ||
                shopController.shop!.id != product.shop!.id)
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () => shopController.addToCart(product),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.tertiary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 4),
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            )
                          ]),
                      child: Text(
                        'Tambahkan ke Keranjang',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            if (shopController.shop != null &&
                shopController.shop!.id == product.shop!.id)
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () => shopController.deleteProduct(product.id),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.tertiary,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 4),
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 6,
                            )
                          ]),
                      child: Text(
                        'Hapus Produk',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
