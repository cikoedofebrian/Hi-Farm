import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/api_key.dart';
import 'package:hifarm/constants/app_color.dart';
import 'package:hifarm/views/widgets/custom_loading_indicator.dart';

class EstimationTime extends StatefulWidget {
  const EstimationTime({Key? key}) : super(key: key);

  @override
  State<EstimationTime> createState() => _EstimationTimeState();
}

class _EstimationTimeState extends State<EstimationTime> {
  final LatLng sellerLocation = Get.arguments;
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _draggedLatlng;
  late final Future future;
  double totalDistance = 0;
  List<LatLng> polylineCoordinates = [];

  Future getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_draggedLatlng.latitude, _draggedLatlng.longitude),
      PointLatLng(sellerLocation.latitude, sellerLocation.longitude),
    );
    if (polylineResult.points.isNotEmpty) {
      for (var element in polylineResult.points) {
        polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      }
      for (var i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += calculateDistance(
            polylineCoordinates[i].latitude,
            polylineCoordinates[i].longitude,
            polylineCoordinates[i + 1].latitude,
            polylineCoordinates[i + 1].longitude);
      }
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future _determineUserCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final currentPosition = await Geolocator.getCurrentPosition();

    _draggedLatlng =
        LatLng(currentPosition.latitude, currentPosition.longitude);
  }

  @override
  void initState() {
    // _init();
    future = _determineUserCurrentPosition().then((_) => getPolyPoints());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: future,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingIndicator();
          }
          _cameraPosition = CameraPosition(
            target: _draggedLatlng, zoom: 5.5, // number of map view
          );
          return Stack(children: [
            _getMap(),
            getEstimationTime(),
          ]);
        });
  }

  Widget getEstimationTime() {
    int totalTime = totalDistance ~/ 300;
    String getTimeString() {
      if (totalTime == 0) {
        return "( 0 - 2 hari )";
      } else {
        return "( $totalTime - ${totalTime + 2} hari )";
      }
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.tertiary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Estimasi Pengiriman',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                          )),
                  Column(
                    children: [
                      Text(
                        "${totalDistance.toStringAsFixed(2)} KM",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColor.primary,
                                ),
                      ),
                      Text(
                        getTimeString(),
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.white,
                                ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Kembali ke Produk',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.tertiary,
                        ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition:
          _cameraPosition!, //initialize camera position for map
      mapType: MapType.normal,
      polylines: {
        Polyline(
          polylineId: const PolylineId('shopToCustomer'),
          points: polylineCoordinates,
          color: AppColor.tertiary,
          width: 5,
        )
      },
      onCameraMove: (cameraPosition) {
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        if (!_googleMapController.isCompleted) {
          _googleMapController.complete(controller);
        }
      },
      markers: {
        Marker(
          markerId: const MarkerId('shop'),
          position: sellerLocation,
        ),
        Marker(
          markerId: const MarkerId('customer'),
          position: _draggedLatlng,
        ),
      },
    );
  }
}
