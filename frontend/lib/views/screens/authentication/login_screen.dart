import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/authcontroller.dart';
import 'package:hifarm/views/widgets/auth_button.dart';
import 'package:hifarm/views/widgets/custom_checkbox.dart';
import 'package:hifarm/views/widgets/rounded_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondary,
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: deviceHeight * 0.3,
                  child: SizedBox(
                    height: deviceHeight * 0.25,
                    child: Image.asset(authImage1),
                  ),
                ),
                Expanded(
                  child: RoundedPage(
                      title: 'Masuk',
                      child: Expanded(
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
                              Obx(
                                () => CustomCheckbox(
                                  checkFunction: authController.changeChecked,
                                  value: authController.isChecked,
                                  name: 'Ingat Saya',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AuthButton(
                                  authFunction: authController.login,
                                  name: 'Masuk'),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Tidak Memiliki Akun ? ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: Colors.grey),
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.offNamed(registerScreen),
                                          child: Text(
                                            'Daftar Akun',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(
                                                    decoration: TextDecoration
                                                        .underline),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Lupa Kata Sandi',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
