import 'package:flutter/material.dart';
import 'package:hifarm/constants/appcolor.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.authFunction,
    required this.name,
  });
  final Function authFunction;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => authFunction(),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2.5),
            )
          ],
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          name,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
