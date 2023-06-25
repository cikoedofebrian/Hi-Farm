import 'package:flutter/material.dart';

class TransactionDetailsItem extends StatelessWidget {
  const TransactionDetailsItem({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            content,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ]),
      const SizedBox(
        height: 10,
      ),
      const Divider(
        height: 2,
        color: Colors.black,
      ),
      const SizedBox(
        height: 10,
      )
    ]);
  }
}
