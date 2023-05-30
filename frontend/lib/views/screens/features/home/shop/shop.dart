import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/views/widgets/scrollable_rounded_page.dart';
import 'package:hifarm/views/widgets/shop_item.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollableRoundedPage(
      topContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Belanja',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: Theme.of(context).textTheme.labelMedium!,
                  decoration: InputDecoration(
                    hintText: 'Ada yang bisa kami bantu?',
                    hintStyle: const TextStyle(
                        color: Colors.grey, overflow: TextOverflow.ellipsis),
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.only(right: 12),
                      icon: const Icon(
                        Icons.search,
                        color: AppColor.secondary,
                      ),
                      onPressed: () {},
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 products per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return const ShopItem();
          },
        ),
      ),
      height: 0.17,
    );
  }
}
