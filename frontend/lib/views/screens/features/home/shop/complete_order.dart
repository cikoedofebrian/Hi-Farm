import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/models/data/adddress_model.dart';
import 'package:hifarm/views/widgets/address_item.dart';
import 'package:hifarm/views/widgets/payment_widget.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/shop_title.dart';

class CompleteOrder extends StatefulWidget {
  const CompleteOrder({super.key});

  @override
  State<CompleteOrder> createState() => _CompleteOrderState();
}

class _CompleteOrderState extends State<CompleteOrder> {
  final Map<String, String> paymentMethod = {
    'DANA': 'assets/payment_type/dana.png',
    'SHOPEEPAY': 'assets/payment_type/shopee.png',
    'GOPAY': 'assets/payment_type/gopay.png',
    'OVO': 'assets/payment_type/ovo.png',
  };

  String _selectedPayment = '';
  MAddress? _selectedAddress;
  final ShopController shopController = Get.find();
  void selectPayment(String type) {
    setState(() {
      _selectedPayment = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pilih Alamat',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () =>
                                    Get.toNamed(addressView, arguments: true)!
                                        .then((value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedAddress = value;
                                    });
                                  }
                                }),
                                child: _selectedAddress == null
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 2, color: Colors.grey)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Pilih Alamat',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const Icon(
                                              Icons.navigate_next_rounded,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      )
                                    : AddressItem(
                                        currentId: 0,
                                        address: _selectedAddress!,
                                        function: () {}),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Pilih Metode Pembayaran',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ...paymentMethod.entries
                                  .map((e) => PaymentWidget(
                                        image: e.value,
                                        isSelected: _selectedPayment == e.key
                                            ? true
                                            : false,
                                        type: e.key,
                                        func: selectPayment,
                                      ))
                                  .toList(),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Produk yang dipilih',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ...List.generate(
                                  shopController.cart.length,
                                  (index) => ShopTitle(
                                      shop: shopController.cart[index].shop,
                                      products: shopController
                                          .cart[index].productList)),
                              const SizedBox(
                                height: 130,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        if (shopController.validateTransaction(
                            _selectedAddress, _selectedPayment)) {
                          Get.toNamed(transactionSuccess, arguments: [
                            _selectedPayment,
                            _selectedAddress!.id
                          ]);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total Harga',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                        "Rp ${shopController.getTotalCartPrice().toString()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)
                                  ]),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(
                                'Selesaikan Transaksi',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColor.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
