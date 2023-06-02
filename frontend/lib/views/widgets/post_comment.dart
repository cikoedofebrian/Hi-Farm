import 'package:flutter/material.dart';

class PostComment extends StatelessWidget {
  const PostComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Image.asset('assets/home_images/Rectangle 160.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Ciko',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Text(
              '23 Mei 2023',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text('Setuju banget !'),
      ]),
    );
  }
}
