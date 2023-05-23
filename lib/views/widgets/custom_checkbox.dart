import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {super.key,
      required this.value,
      required this.name,
      required this.checkFunction});

  final bool value;
  final String name;
  final Function checkFunction;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => widget.checkFunction(),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: formColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget.value
                ? const Icon(
                    Icons.check_rounded,
                    size: 20,
                    color: Colors.green,
                  )
                : null,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          widget.name,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
        )
      ],
    );
  }
}
