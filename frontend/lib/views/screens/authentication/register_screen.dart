import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/controllers/auth_controller.dart';
import 'package:hifarm/views/widgets/auth_button.dart';
import 'package:hifarm/views/widgets/rounded_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = '';
  String email = '';
  String password = '';
  String confirmationPassword = '';
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();

  void tryRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      authController.register(name, password, email, confirmationPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  color: AppColor.secondary,
                  alignment: Alignment.center,
                  height: size * 0.18,
                  child: SizedBox(
                    height: size * 0.12,
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
                  height: 80,
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
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email tidak boleh kosong";
                            } else if (!EmailValidator.validate(value)) {
                              return "Email tidak valid";
                            }
                            return null;
                          },
                          onSaved: (newValue) => email = newValue!,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Name',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Nama tidak boleh kosong";
                            }
                            return null;
                          },
                          onSaved: (newValue) => name = newValue!,
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
                              } else if (value.length < 6) {
                                return "Password tidak boleh kurang dari 6 karakter";
                              }
                              return null;
                            },
                            onSaved: (newValue) => password = newValue!,
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
                          () => TextFormField(
                            obscureText: !authController.isVisible,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password tidak boleh kosong";
                              } else if (value.length < 6) {
                                return "Password tidak boleh kurang dari 6 karakter";
                              }
                              return null;
                            },
                            onSaved: (newValue) =>
                                confirmationPassword = newValue!,
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
                          height: 30,
                        ),
                        AuthButton(
                          authFunction: tryRegister,
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
