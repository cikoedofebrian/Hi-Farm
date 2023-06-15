import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/views/widgets/auth_button.dart';
import 'package:hifarm/views/widgets/custom_checkbox.dart';
import 'package:hifarm/views/widgets/rounded_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  void tryLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      authController.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.secondary,
        body: SingleChildScrollView(
          child: SizedBox(
            height: deviceHeight,
            child: Form(
              key: _formKey,
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
                        height: 80,
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
                                TextFormField(
                                  onSaved: (newValue) => email = newValue!,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email tidak boleh kosong";
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return "Email tidak valid";
                                    }
                                    return null;
                                  },
                                ),
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
                                  () => TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password tidak boleh kosong";
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) => password = newValue!,
                                    obscureText: !authController.isVisible,
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12),
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
                                  authFunction: tryLogin,
                                  name: 'Masuk',
                                ),
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
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Get.offNamed(registerScreen),
                                              child: Text(
                                                'Daftar Akun',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Lupa Kata Sandi',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
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
      ),
    );
  }
}
