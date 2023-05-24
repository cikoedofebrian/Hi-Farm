import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/authcontroller.dart';
import 'package:hifarm/views/widgets/auth_button.dart';
import 'package:hifarm/views/widgets/custom_checkbox.dart';
import 'package:hifarm/views/widgets/rounded_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, snapshot) => Scaffold(
          backgroundColor: secondary,
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: snapshot.maxHeight * 0.18,
                  child: SizedBox(
                    height: snapshot.maxHeight * 0.12,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Text(
                            'Siap menjadi petani proffesional!',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        Image.asset(authImage1),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                RoundedPage(
                  title: 'Daftar',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TextField(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Username',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const TextField(),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Password',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => TextField(
                            obscureText: !authController.isVisible,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: IconButton(
                                  onPressed: () =>
                                      authController.changeVisible(),
                                  icon: Icon(authController.isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Konfirmasi Password',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => TextField(
                            obscureText: !authController.isVisible,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: IconButton(
                                  onPressed: () =>
                                      authController.changeVisible(),
                                  icon: Icon(authController.isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => CustomCheckbox(
                            checkFunction: authController.changeChecked,
                            value: authController.isChecked,
                            name: 'Otomatis masuk setelah mendaftar',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        AuthButton(
                          authFunction: authController.register,
                          name: 'Daftar',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah Memiliki Akun ? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () => Get.offNamed(loginScreen),
                              child: Text(
                                'Masuk',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 60,
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
