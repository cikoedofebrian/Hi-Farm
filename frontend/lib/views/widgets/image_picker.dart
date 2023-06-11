import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> imagePicker(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  File? photo;
  await showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Text(
                'Pilih salah satu metode dibawah :',
                style: TextStyle(fontSize: 16),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil foto baru'),
              onTap: () async {
                final XFile? pickedPhoto = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 30);
                if (pickedPhoto != null) {
                  photo = File(pickedPhoto.path);
                  Get.back();
                }
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading: const Icon(Icons.image),
              title: const Text('Pilih dari galeri'),
              onTap: () async {
                final XFile? pickedPhoto = await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 30);
                if (pickedPhoto != null) {
                  photo = File(pickedPhoto.path);
                  Get.back();
                }
              },
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      );
    },
  );
  return photo;
}
