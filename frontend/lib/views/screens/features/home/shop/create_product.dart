import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/controllers/shop_controller.dart';
import 'package:hifarm/views/widgets/image_picker.dart';
import 'package:hifarm/views/widgets/photo_container.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;

  final ShopController _shopController = Get.find();
  File? _photo;
  @override
  void initState() {
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _imagePicker() async {
    File? photo = await imagePicker(context);
    if (photo != null) {
      setState(() {
        _photo = photo;
      });
    }
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
                        'Buat Produk Baru',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
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
                              'Unggah Foto',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return SizedBox(
                                    height: constraints.maxWidth,
                                    width: constraints.maxWidth,
                                    child: _photo != null
                                        ? Image.file(
                                            _photo!,
                                            fit: BoxFit.cover,
                                          )
                                        : addPhotoContainer(
                                            context, _imagePicker));
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Nama Produk',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _nameController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Harga',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _priceController,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => _shopController.createProduct(
                            _nameController.text,
                            _priceController.text,
                            _photo,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColor.secondary,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Buat Produk',
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
