import 'package:flutter/material.dart';

InkWell addPhotoContainer(BuildContext context, Function onTapFunction) {
  return InkWell(
    onTap: () => onTapFunction(),
    child: Container(
      color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.photo,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Tambahkan Foto',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white,
                ),
          )
        ],
      ),
    ),
  );
}
