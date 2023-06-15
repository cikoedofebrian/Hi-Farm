import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';

class TransactionSuccess extends StatelessWidget {
  const TransactionSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopController shopController = Get.find();
    final List<dynamic> argument = Get.arguments;
    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: FutureBuilder(
          future: shopController.createTransaction(argument[0], argument[1]),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CustomLoadingIndicator(
                color: AppColor.primary,
              ));
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColor.primary,
                            size: 160,
                          ),
                          Text(
                            'Transaksi Berhasil!',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            'Cek status pesanan anda di menu profil',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ]),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () => Get.toNamed(homeScreen),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Kembali ke Beranda',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: AppColor.secondary,
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
