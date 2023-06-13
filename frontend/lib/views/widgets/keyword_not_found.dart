import 'package:flutter/material.dart';

class KeywordNotFound extends StatelessWidget {
  const KeywordNotFound({super.key, required this.description, this.title});
  final String description;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Text(
          title ?? 'Maaf!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
