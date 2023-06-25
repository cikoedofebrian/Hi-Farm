import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/adddress_model.dart';
import 'package:hifarm/views/widgets/address_item.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class ViewAddress extends StatefulWidget {
  const ViewAddress({super.key});

  @override
  State<ViewAddress> createState() => _ViewAddressState();
}

class _ViewAddressState extends State<ViewAddress> {
  final HomeController homeController = Get.find();
  List<MAddress> _addressList = [];
  final bool isOnSelecting = Get.arguments;
  final ShopController shopController = Get.find();
  int currentId = 0;

  Future<void> getAddress() async {
    final data = await shopController.getAddress();
    _addressList = data;
  }

  late final Future future;
  @override
  void initState() {
    future = getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
          future: future,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingIndicator();
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      await getAddress();
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.navigate_before_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  Text(
                                    'Alamat',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const RoundedTopPadding(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _addressList
                                  .map((e) => AddressItem(
                                      currentId: currentId,
                                      address: e,
                                      function: () {
                                        if (isOnSelecting) {
                                          setState(() {
                                            currentId = e.id;
                                          });
                                        }
                                      }))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // if (shopController.shop != null &&
                  //     shopController.shop!.id != product.shop!.id)
                  //   Positioned(
                  //     bottom: 0,
                  //     right: 0,
                  //     left: 0,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(20),
                  //       child: InkWell(
                  //         onTap: () => shopController.addToCart(product),
                  //         child: Container(
                  //           alignment: Alignment.center,
                  //           padding: const EdgeInsets.symmetric(vertical: 15),
                  //           width: double.infinity,
                  //           decoration: BoxDecoration(
                  //               color: AppColor.tertiary,
                  //               borderRadius: BorderRadius.circular(10),
                  //               boxShadow: const [
                  //                 BoxShadow(
                  //                   offset: Offset(4, 4),
                  //                   color: Colors.black26,
                  //                   spreadRadius: 1,
                  //                   blurRadius: 6,
                  //                 )
                  //               ]),
                  //           child: Text(
                  //             'Tambahkan ke Keranjang',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .titleMedium!
                  //                 .copyWith(
                  //                   color: Colors.white,
                  //                 ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   )

                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: isOnSelecting ? 0 : null,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: isOnSelecting
                          ? InkWell(
                              onTap: () => Get.back(
                                result: currentId != 0
                                    ? _addressList.firstWhere(
                                        (element) => element.id == currentId)
                                    : null,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: AppColor.secondary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Pilih Alamat',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () => Get.toNamed(addAddress),
                              child: CircleAvatar(
                                radius: 36,
                                backgroundColor: AppColor.secondary,
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: 30,
                                    color: homeController.isDarkTheme
                                        ? Colors.white
                                        : AppColor.tertiary,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
