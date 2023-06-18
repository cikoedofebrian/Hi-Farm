import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/constants/image_string.dart';
import 'package:hifarm/constants/routes.dart';
import 'package:hifarm/models/data/post_model.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({
    super.key,
    required this.data,
  });

  final MPost data;

  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: 'id');
    Placemark address = placemarks[0];
    return address.subAdministrativeArea;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Get.toNamed(postDetails, arguments: data.id),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: data.user.pic != null
                                ? NetworkImage(data.user.pic!)
                                : const AssetImage(emptyProfile)
                                    as ImageProvider,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(data.user.name),
                        ],
                      ),
                      const Icon(Icons.more_vert_rounded)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(data.description),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  height: size.width,
                  child: PageView.builder(
                    itemCount: data.pics.length,
                    itemBuilder: (context, index) => Image.network(
                      data.pics[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: FutureBuilder(
                      future: _getAddress(LatLng(data.lt, data.ln)),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        return Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: AppColor.secondary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.location_on,
                                    color: AppColor.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  snapshot.data,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ));
                      }),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
