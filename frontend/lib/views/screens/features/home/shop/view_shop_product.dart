import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/keyword_not_found.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/shop_item.dart';

class ViewShopProduct extends StatelessWidget {
  const ViewShopProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: FutureBuilder(
          future: shopController.getShopProducts(shopController.shop!.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingIndicator();
            }
            final productsData = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomLeft,
                    height: MediaQuery.of(context).size.height * 0.16,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 60, bottom: 20),
                    color: AppColor.secondary,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.navigate_before_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        Text(
                          'Produk dari Toko',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const RoundedTopPadding(),
                  Container(
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


// class CreateProduct extends StatefulWidget {
//   const CreateProduct({super.key});

//   @override
//   State<CreateProduct> createState() => _CreateProductState();
// }

// class _CreateProductState extends State<CreateProduct> {
//   late final TextEditingController _nameController;
//   late final TextEditingController _priceController;

//   final ShopController _shopController = Get.find();
//   File? _photo;
//   @override
//   void initState() {
//     _nameController = TextEditingController();
//     _priceController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }



