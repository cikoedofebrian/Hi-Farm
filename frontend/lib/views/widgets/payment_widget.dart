import 'package:flutter/material.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget(
      {super.key,
      required this.image,
      required this.isSelected,
      required this.type,
      required this.func});
  final String type;
  final String image;
  final bool isSelected;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => func(type),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.black12,
          ),
        ),
        child: Row(children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 25,
                  child: Image.asset(image),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  type,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: Colors.black12),
            ),
            child: CircleAvatar(
              backgroundColor: isSelected ? Colors.black12 : Colors.white,
              radius: 6,
            ),
          )
        ]),
      ),
    );
  }
}
