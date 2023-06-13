import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostComment extends StatelessWidget {
  const PostComment({
    super.key,
    required this.comment,
    required this.date,
    required this.image,
    required this.name,
  });

  final String name;
  final String? image;
  final DateTime date;
  final String comment;
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
                CircleAvatar(
                  backgroundImage: image != null
                      ? NetworkImage(image!)
                      : const AssetImage('assets/home_images/empty_pic.jpg')
                          as ImageProvider,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Text(
              DateFormat('dd-MM-yyyy').format(date),
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
        Text(comment),
      ]),
    );
  }
}
