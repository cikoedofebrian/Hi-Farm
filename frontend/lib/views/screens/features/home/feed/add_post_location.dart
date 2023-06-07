// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hifarm/constants/appcolor.dart';

// class AddPostLocation extends StatefulWidget {
//   const AddPostLocation({super.key});

//   @override
//   State<AddPostLocation> createState() => AddPostLocationState();
// }

// class AddPostLocationState extends State<AddPostLocation> {
//   Completer<GoogleMapController> _googleMapController = Completer();
//   Future<Position> _determineCurrentPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> _gotoUserCurrentPosition() async {
//     Position currentPosition = await _determineCurrentPosition();
//     _gotoSpecificPosition(
//         LatLng(currentPosition.latitude, currentPosition.longitude));
//   }

//   Future _gotoSpecificPosition(LatLng position) async {
//     GoogleMapController mapController = await _googleMapController.future;
//       mapController.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: position, zoom: 17.5)));

//     //every time that we dragged pin , it will list down the address here
//   }

//   late Future _future;

//   @override
//   void initState() {
//     _future = _determineCurrentPosition();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: _future,
//         builder: (_, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.error != null) {
//             Get.back();
//           }
//           return Stack(
//             children: [
//               GoogleMap(
//                 mapType: MapType.hybrid,
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                     snapshot.data!.latitude,
//                     snapshot.data!.longitude,
//                   ),
//                   zoom: 16,
//                 ),
//                 onMapCreated: (GoogleMapController controller) {
//                   if (!_googleMapController.isCompleted) {
//                     _googleMapController.complete(controller);
//                   }
//                 },
//                 zoomControlsEnabled: false,
//               ),
// Positioned(
//   bottom: 0,
//   left: 0,
//   right: 0,
//   child: Padding(
//     padding: const EdgeInsets.all(20),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         GestureDetector(
//           onTap: () {
//             _gotoUserCurrentPosition();
//           },
//           child: const CircleAvatar(
//             radius: 28,
//             backgroundColor: Colors.white,
//             child: Icon(
//               Icons.location_on,
//               color: AppColor.secondary,
//               size: 28,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Container(
//           alignment: Alignment.center,
//           height: 60,
//           decoration: BoxDecoration(
//             color: AppColor.secondary,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text(
//             'Pakai Lokasi Ini',
//             style: Theme.of(context)
//                 .textTheme
//                 .titleMedium!
//                 .copyWith(color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//   ),
// )
//   ],
// );
//         },
//       ),
//     );
//   }

//   // Future<void> _goToTheLake() async {
//   //   final GoogleMapController controller = await _controller.future;
//   //   await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   // }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hifarm/constants/appcolor.dart';
import 'package:lottie/lottie.dart';

class AddPostLocation extends StatefulWidget {
  const AddPostLocation({Key? key}) : super(key: key);

  @override
  State<AddPostLocation> createState() => _AddPostLocationState();
}

class _AddPostLocationState extends State<AddPostLocation> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  // late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  String _draggedAddress = "";
  late final Future future;

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

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    // _init();
    future = _determineUserCurrentPosition();
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final Position currentPosition = snapshot.data as Position;
          _draggedLatlng =
              LatLng(currentPosition.latitude, currentPosition.longitude);
          _cameraPosition = CameraPosition(
              target: _draggedLatlng, zoom: 17.5 // number of map view
              );
          return Stack(children: [
            _getMap(),
            _getCustomPin(),
            _showDraggedAddress(),
            _getBottomFunction(),
          ]);
        });
  }

  Widget _getBottomFunction() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                _gotoUserCurrentPosition();
              },
              child: InkWell(
                onTap: _gotoUserCurrentPosition,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 3),
                          color: Colors.black12,
                          blurRadius: 2,
                          spreadRadius: 2,
                        ),
                      ]),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColor.secondary,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => Get.back(result: [
                _draggedLatlng,
                _draggedAddress,
              ]),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(2, 3),
                      color: Colors.black12,
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ],
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Pakai Lokasi Ini',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDraggedAddress() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Text(
              'Lokasi saat ini :',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 3),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 2,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Text(
              _draggedAddress,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppColor.secondary,
                  ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _getMap() {
    return GoogleMap(
      zoomControlsEnabled: false,
      initialCameraPosition:
          _cameraPosition!, //initialize camera position for map
      mapType: MapType.normal,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of latlng
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 200,
        child: Lottie.asset("assets/icons/pin.json"),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      _draggedAddress = addresStr;
    });
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }
}
