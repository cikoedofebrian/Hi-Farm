import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/keyword_not_found.dart';
import 'package:hifarm/views/widgets/scrollable_rounded_page.dart';
import 'package:hifarm/views/widgets/shop_item.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    if (shopController.isLoading) {
      shopController.fetchProduct();
    }
    return Obx(() {
      if (shopController.isLoading) {
        return const CustomLoadingIndicator();
      }
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: RefreshIndicator(
          onRefresh: () async {
            shopController.changeLoading(true);
            shopController.fetchProduct();
          },
          child: ScrollableRoundedPage(
            topContent: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Belanja',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        style: Theme.of(context).textTheme.labelMedium!,
                        decoration: InputDecoration(
                          hintText: 'Ada yang bisa kami bantu?',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(right: 12),
                            icon: const Icon(
                              Icons.search,
                              color: AppColor.secondary,
                            ),
                            onPressed: () => shopController
                                .searchProduct(_textEditingController.text),
                          ),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(viewCart),
                      child: Stack(
                        children: [
                          const Iconify(
                            Ph.shopping_cart_bold,
                            size: 30,
                            color: Colors.white,
                          ),
                          Obx(
                            () => Positioned(
                              right: 0,
                              top: 0,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: AppColor.tertiary,
                                child: Text(
                                  shopController
                                      .getTotalCartProduct()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: shopController.productList.isNotEmpty
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
                      itemCount: shopController.productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ShopItem(
                          id: shopController.productList[index].id,
                          city: shopController.productList[index].city,
                          image: shopController.productList[index].image,
                          name: shopController.productList[index].name,
                          price: shopController.productList[index].price,
                        );
                      },
                    )
                  : const KeywordNotFound(
                      description: 'Produk dengan keyword ini belum tersedia'),
            ),
            height: 0.17,
          ),
        ),
      );
    });
  }
}
