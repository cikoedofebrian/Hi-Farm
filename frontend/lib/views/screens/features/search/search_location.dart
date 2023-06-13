import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/api_link.dart';
import 'package:hifarm/constants/api_method.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:hifarm/helpers/api_request_sender.dart';
import 'package:hifarm/models/page_data/search_location_model.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  List<MSearchLocation> locationList = [];
  Future<void> updateSearch(String text) async {
    List<MSearchLocation> tempList = [];
    String url =
        '${ApiLink.mapsComplete}$text${ApiLink.language}${ApiLink.key}';
    final result =
        await ApiRequestSender.sendHttpRequest(ApiMethod.get, url, null);
    for (var i in result['predictions']) {
      tempList.add(
          MSearchLocation(address: i['description'], placeId: i['place_id']));
    }
    setState(() {
      locationList = tempList;
    });
  }

  Future<LatLng> getLocation(String placeId) async {
    String url =
        '${ApiLink.mapsDetails}$placeId${ApiLink.language}${ApiLink.key}';
    final getData =
        await ApiRequestSender.sendHttpRequest(ApiMethod.get, url, null);
    final rawLocation = getData['result']['geometry']['location'];
    return LatLng(rawLocation['lat'], rawLocation['lng']);
  }

  Widget locationData(MSearchLocation loc) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final location = await getLocation(loc.placeId);
              Get.back(result: location);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_sharp,
                  size: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  loc.address,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 2,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: AppColor.secondary,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.navigate_before_rounded,
                        size: 50,
                        color: AppColor.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Cari Lokasi',
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) => updateSearch(value),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: AppColor.secondary,
                                    ),
                              ),
                            ),
                            const Icon(
                              Icons.search_rounded,
                              color: AppColor.secondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ...locationList.map((e) => locationData(e)).toList()
            ],
          ),
        ),
      ),
    );
  }
}
