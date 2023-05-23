import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/controllers/homecontroller.dart';
import 'package:hifarm/views/widgets/custom_navbar.dart';
import 'package:hifarm/views/widgets/rounded_item.dart';
import 'package:hifarm/views/widgets/rounded_page.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/oi.dart';
import 'package:iconify_flutter/icons/ph.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(
    HomeController(),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: SizedBox(
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        floating: false,
                        backgroundColor: secondary,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.19,
                        pinned: false,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        height: 56,
                                        child: Image.asset(homeImage1)),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Halo, Rahel!',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                          ),
                                          Text(
                                            'Bagaimana keadaan peternakanmu?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Ada yang bisa kami bantu?',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              overflow: TextOverflow.ellipsis),
                                          suffixIcon: IconButton(
                                            padding: const EdgeInsets.only(
                                                right: 12),
                                            icon: const Icon(
                                              Icons.search,
                                              color: secondary,
                                            ),
                                            onPressed: () {},
                                          ),
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    const Iconify(
                                      Majesticons.messages_line,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Iconify(
                                      Ph.shopping_cart_bold,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Stack(
                            children: [
                              Container(
                                height: 80,
                                color: secondary,
                              ),
                              RoundedItem(
                                child: Container(
                                  color: Colors.white,
                                  height: 2000,
                                ),
                              )
                            ],
                          ),
                          childCount: 1,
                        ),
                      )
                    ],
                  ),
                  Positioned(bottom: 0, child: CustomNav()),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
