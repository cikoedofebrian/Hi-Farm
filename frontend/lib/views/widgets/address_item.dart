import 'package:flutter/material.dart';
import 'package:hifarm/models/data/adddress_model.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.currentId,
    required this.address,
    required this.function,
  });
  final MAddress address;
  final int currentId;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => function(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
            color: currentId == address.id
                ? Colors.grey.shade700
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                address.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                address.phone.toString(),
                style: Theme.of(context).textTheme.titleSmall!.copyWith(),
              ),
              Text(
                address.address,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
