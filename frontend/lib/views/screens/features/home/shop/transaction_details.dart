import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/transaction_model.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/transaction_details_item.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final List<dynamic> args = Get.arguments;
  final ShopController shopController = Get.find();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final MTransaction transaction = args[0];
    final bool isUser = args[1];

    Widget getProduct(int quantity, String name, String image) {
      return Column(
        children: [
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "Qty : $quantity",
                      ),
                    ],
                  )
                ],
              ),
            ],
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

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
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
                          'Detail Transaksi',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const RoundedTopPadding(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TransactionDetailsItem(
                            title: 'Tanggal',
                            content: DateFormat('dd-MM-yyy')
                                .format(transaction.date)),
                        TransactionDetailsItem(
                            title: 'Metode Pembayaran',
                            content: transaction.payment),
                        const SizedBox(
                          height: 20,
                        ),
                        if (isUser) ...[
                          Text(
                            'Penjual',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 20,
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () => Get.toNamed(
                                      estimationTime,
                                      arguments: transaction.shop.loc,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      arguments: transaction.shop),
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
                                                transaction.shop.name,
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
                                                    transaction.shop.address,
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
                        ],
                        if (!isUser) ...[
                          Text(
                            'Data Penerima',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TransactionDetailsItem(
                            title: 'Nama Penerima',
                            content: transaction.customer.name,
                          ),
                          TransactionDetailsItem(
                            title: 'No Telepon',
                            content: transaction.address.phone.toString(),
                          ),
                          TransactionDetailsItem(
                            title: 'Alamat',
                            content: transaction.address.address,
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Produk',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ...List.generate(
                            transaction.products.length,
                            (index) => getProduct(
                                  transaction.products[index].quantity,
                                  transaction.products[index].product.name,
                                  transaction.products[index].product.image,
                                ))
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (!isUser)
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
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
                        'Berikan No Resi',
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
