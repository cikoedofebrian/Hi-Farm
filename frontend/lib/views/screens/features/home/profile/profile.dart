import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/views/widgets/rounded_top_padding.dart';
import 'package:hifarm/views/widgets/small_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          width: double.infinity,
          color: AppColor.secondary,
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 30),
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
                    width: 100,
                    child: Image.asset('assets/home_images/Rectangle 160.png'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SmallButton(function: () {}, text: 'Ubah Gambar'),
                  const SizedBox(
                    height: 40,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text('Nama'),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Text('Ciko Edo Febrian'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text('Email'),
                      ),
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Text('ciko.edo.febrians@gmail.com'),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SmallButton(function: () {}, text: 'Log Out'),
                  const SizedBox(
                    height: 140,
                  ),
                ],
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
