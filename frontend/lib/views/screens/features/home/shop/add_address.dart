import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  late final TextEditingController _titleController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneNumController;
  final ShopController _shopController = Get.find();
  LatLng? location;

  @override
  void initState() {
    _titleController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumController = TextEditingController();
    _addressController.text = 'Pilih Lokasi';
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _addressController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
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
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Tambah Alamat",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const RoundedTopPadding(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama Alamat',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _titleController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No Telepon',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _phoneNumController,
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
                                      location = value[0];
                                      _addressController.text = value[1];
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: InkWell(
                    onTap: () => _shopController.createAddress(
                      _titleController.text,
                      _phoneNumController.text,
                      location,
                      _addressController.text,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          color: AppColor.secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Buat Alamat',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
