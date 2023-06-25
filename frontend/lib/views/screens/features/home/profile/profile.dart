import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/controllers/home_controller.dart';
import 'package:hifarm/controllers/user_controller.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';
import 'package:hifarm/views/widgets/image_picker.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/small_button.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isOnEdit = false;
  File? newPhoto;
  var appColor = AppColor();
  final HomeController homeController = Get.find();
  final AuthController authController = Get.find();
  final UserController userController = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (userController.isLoading) {
      userController.fetchUserData();
    }

    void takeImage() async {
      File? photo = await imagePicker(context);
      if (photo != null) {
        setState(() {
          newPhoto = photo;
        });
      }
    }

    void changeEditStatus() {
      setState(() {
        isOnEdit = !isOnEdit;
        if (!isOnEdit) {
          newPhoto = null;
          nameController.text = userController.user.name;
          emailController.text = userController.user.email;
        }
      });
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Obx(() {
          if (userController.isLoading) {
            return const CustomLoadingIndicator();
          }

          emailController.text = userController.user.email;
          nameController.text = userController.user.name;
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Container(
                  width: double.infinity,
                  color: AppColor.secondary,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 40, bottom: 30),
                  child: Text(
                    'Profile',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const RoundedTopPadding(),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            // width: 100,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: newPhoto != null
                                      ? FileImage(newPhoto!)
                                      : userController.user.pic != null
                                          ? NetworkImage(
                                              userController.user.pic!)
                                          : const AssetImage(emptyProfile)
                                              as ImageProvider,
                                ),
                                if (isOnEdit)
                                  Positioned(
                                    right: 0,
                                    child: InkWell(
                                      onTap: takeImage,
                                      child: const CircleAvatar(
                                        backgroundColor: AppColor.tertiary,
                                        radius: 14,
                                        child: Icon(
                                          Icons.camera,
                                          size: 16,
                                          color: AppColor.primary,
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmallButton(
                                  function: changeEditStatus,
                                  text: 'Edit Profile'),
                              if (isOnEdit) ...[
                                const SizedBox(
                                  width: 10,
                                ),
                                SmallButton(
                                  function: () async {
                                    await userController.updateUser(
                                        emailController.text,
                                        nameController.text,
                                        newPhoto);
                                    changeEditStatus();
                                  },
                                  text: 'Simpan',
                                  color: AppColor.secondary,
                                )
                              ]
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Nama',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    filled: false,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  controller: nameController,
                                  enabled: isOnEdit,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Email',
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                fit: FlexFit.tight,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    filled: false,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                  controller: emailController,
                                  enabled: isOnEdit,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () => Get.toNamed(userTransactionList,
                                arguments: true),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.secondary),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.secondary,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    spreadRadius: 1,
                                    color: Colors.black12,
                                    blurRadius: 2,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'Lihat Histori Transaksi',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColor.primary,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () =>
                                Get.toNamed(addressView, arguments: false),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.secondary),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.secondary,
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(2, 2),
                                    spreadRadius: 1,
                                    color: Colors.black12,
                                    blurRadius: 2,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: Text(
                                'Lihat Alamat Tersimpan',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColor.primary,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dark Mode',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Switch(
                                activeColor: AppColor.secondary,
                                inactiveThumbColor: AppColor.tertiary,
                                value: homeController.isDarkTheme,
                                onChanged: (value) {
                                  if (homeController.isDarkTheme) {
                                    Get.changeThemeMode(ThemeMode.light);
                                  } else {
                                    Get.changeThemeMode(ThemeMode.dark);
                                  }
                                  homeController.changeTheme();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SmallButton(
                            function: authController.logout,
                            text: 'Log Out',
                          ),
                          const SizedBox(
                            height: 140,
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ]),
            ),
          );
        }),
      ),
    );
  }
}
