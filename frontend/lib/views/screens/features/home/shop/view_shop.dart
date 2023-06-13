import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class ViewShop extends StatefulWidget {
  const ViewShop({super.key});

  @override
  State<ViewShop> createState() => _ViewShopState();
}

class _ViewShopState extends State<ViewShop> {
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  final ShopController _shopController = Get.find();
  LatLng? location;
  bool isOnEdit = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _nameController.text = _shopController.shop!.name;
    _addressController.text = _shopController.shop!.address;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
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
                              "Toko Anda",
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
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Toko',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              enabled: isOnEdit,
                              controller: _nameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Lokasi',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () => isOnEdit
                                  ? Get.toNamed(addPostLocation)!.then((value) {
                                      if (value != null) {
                                        setState(() {
                                          location = value[0];
                                          _addressController.text = value[2];
                                        });
                                      }
                                    })
                                  : null,
                              child: TextField(
                                controller: _addressController,
                                enabled: false,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.secondary),
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.primary,
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(2, 2),
                                      spreadRadius: 1,
                                      color: Colors.black12,
                                      blurRadius: 2,
                                    )
                                  ]),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              child: Text(
                                'Lihat Pesanan Masuk',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColor.secondary,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => Get.toNamed(createProduct),
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.secondary),
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColor.secondary,
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(2, 2),
                                        spreadRadius: 1,
                                        color: Colors.black12,
                                        blurRadius: 2,
                                      )
                                    ]),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.center,
                                child: Text(
                                  'Buat Produk Baru',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: AppColor.primary,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isOnEdit = !isOnEdit;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              !isOnEdit ? 'Edit Toko' : 'Simpan',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
