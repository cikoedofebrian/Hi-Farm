import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/transaction_model.dart';
import 'package:hifarm/models/page_data/cart_model.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/teenyicons.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final bool isUser = Get.arguments;
  final ShopController shopController = Get.find();
  int index = 0;

  void changeIndex(int value) {
    setState(() {
      index = value;
    });
  }

  List<MTransaction> getTransactionData() {
    switch (index) {
      case 1:
        return list.where((element) => element.status == "delivery").toList();

      case 2:
        return list.where((element) => element.status == "delivered").toList();

      default:
        return list.where((element) => element.status == "packaging").toList();
    }
  }

  List<MTransaction> list = [];
  late final Future future;
  @override
  void initState() {
    future = shopController.getTransaction(isUser).then((value) {
      setState(() {
        list = value;
      });
    });
    super.initState();
  }

  int getTotalPrice(List<MInsideCart> cart) {
    int total = 0;
    for (var i in cart) {
      total += i.quantity * i.product.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final transactionData = getTransactionData();
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: FutureBuilder(
          future: future,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoadingIndicator();
            }

            return SingleChildScrollView(
              child: Column(children: [
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
                        'Transaksi',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const RoundedTopPadding(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => changeIndex(0),
                        child: Column(children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('Dikemas')),
                          Container(
                            height: 4,
                            color: index == 0 ? Colors.black12 : Colors.white,
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => changeIndex(1),
                        child: Column(children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('Dikirim')),
                          Container(
                            height: 4,
                            color: index == 1 ? Colors.black12 : Colors.white,
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => changeIndex(2),
                        child: Column(children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text('Terkirim')),
                          Container(
                            height: 4,
                            color: index == 2 ? Colors.black12 : Colors.white,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: List.generate(
                      transactionData.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: InkWell(
                          onTap: () => Get.toNamed(transactionDetails,
                              arguments: [transactionData[index], isUser]),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: isUser
                                      ? Row(
                                          children: [
                                            const Iconify(
                                              Teenyicons.shop_solid,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(transactionData[index]
                                                .shop
                                                .name),
                                          ],
                                        )
                                      : Text(
                                          "Kepada ${transactionData[index].customer.name}"),
                                ),
                                const Divider(
                                  height: 2,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Image.network(
                                        transactionData[index]
                                            .products[0]
                                            .product
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transactionData[index]
                                              .products[0]
                                              .product
                                              .name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Text(
                                          "Qty : ${transactionData[index].products[0].quantity.toString()}",
                                        ),
                                      ],
                                    ),
                                    if (transactionData[index].products.length >
                                        1)
                                      CircleAvatar(
                                        radius: 27,
                                        backgroundColor: AppColor.secondary,
                                        child: CircleAvatar(
                                          backgroundColor: AppColor.primary,
                                          radius: 24,
                                          child: Text(
                                            "+ ${transactionData[index].products.length - 1}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                  color: AppColor.secondary,
                                                ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Transaksi',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                        "Rp ${getTotalPrice(transactionData[index].products)}"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
            );
          }),
    );
  }
}
