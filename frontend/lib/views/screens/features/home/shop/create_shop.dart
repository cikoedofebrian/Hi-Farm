import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class CreateShop extends StatefulWidget {
  const CreateShop({super.key});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  late final TextEditingController _nameController;
  late final TextEditingController _addressController;
  late final TextEditingController _descriptionController;
  final ShopController _shopController = Get.find();
  LatLng? location;

  @override
  void initState() {
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _descriptionController = TextEditingController();
    _addressController.text = 'Pilih Lokasi';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
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
                              "Anda Belum Membuka Toko!",
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
                            const Text(
                              'Yuk segera daftarin segera toko mu, biar makin cepet kaya!',
                              style: TextStyle(color: Colors.white),
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
                              controller: _nameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Deskripsi',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                              ),
                              maxLines: 5,
                              controller: _descriptionController,
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
                              onTap: () =>
                                  Get.toNamed(addPostLocation)!.then((value) {
                                if (value != null) {
                                  setState(() {
                                    print(value[0]);
                                    location = value[0];
                                    _addressController.text = value[2];
                                  });
                                }
                              }),
                              child: TextField(
                                controller: _addressController,
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => _shopController.createShop(
                            _nameController.text,
                            location,
                            _addressController.text,
                            _descriptionController.text,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Buat Toko',
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
