import 'dart:async';

import 'package:datingapp/data/current_user.dart';
import 'package:datingapp/style/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart';

class LocationTab extends StatefulWidget {
  final CurrentUser currentUser;
  final Function() updateIndex;

  const LocationTab(
      {super.key, required this.currentUser, required this.updateIndex});

  @override
  State<LocationTab> createState() => LocationTabState();
}

class LocationTabState extends State<LocationTab> {
  late final Future currentPositionAvailable;
  late String _mapStyle;
  String addressStatus = "";
  Position? _currentPosition;
  late CameraPosition cameraPosition;
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  String errorMessage = "";
  late List<Placemark> finalLocation;

  Future getLocationOnLoad() async {
    await _getCurrentPosition();
    cameraPosition = CameraPosition(
      target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      zoom: 14.4746,
    );
    if (_currentPosition != null) {
      return true;
    }
  }

  @override
  void initState() {
    rootBundle.loadString('assets/mapstyle/map_style.txt').then((string) {
      _mapStyle = string;
    });
    currentPositionAvailable = getLocationOnLoad();
    super.initState();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      errorMessage =
          'Location services are disabled. Please enable the services';
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        errorMessage = 'Location permissions are denied';
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      errorMessage =
          'Location permissions are permanently denied, we cannot request permissions.';
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void updateAddress(List<Placemark> placemarks) {
    setState(() {
      addressStatus =
          '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
    });
  }

  String getErrorMessage() {
    return errorMessage;
  }

  bool validateLocation() {
    if (finalLocation.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> updateUserAddress() async {
    if (finalLocation.isNotEmpty) {
      widget.currentUser.setCity = finalLocation.first.locality.toString();
      widget.currentUser.setState =
          finalLocation.first.administrativeArea.toString();
      widget.currentUser.setCountry = finalLocation.first.country.toString();
      widget.currentUser.setZipcode = finalLocation.first.postalCode.toString();
    }
  }

  @override
  String toStringShort() {
    return errorMessage;
  }

  void showErrorDialog() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: const Text(
                'Whoops!',
                style: TextStyle(fontSize: 18),
              ),
              content: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    errorMessage.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Okay",
                    style: TextStyle(color: AppStyle.red800),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return FutureBuilder(
      future: currentPositionAvailable,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == true) {
          return Column(
            children: [
              Wrap(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        "Where do you live?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontFamily: 'Marlide-Display',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: availableHeight - 400,
                child: MapPicker(
                  // pass icon widget
                  iconWidget:
                      Icon(Icons.location_on, color: AppStyle.red500, size: 40),
                  //add map picker controller
                  mapPickerController: mapPickerController,
                  child: GoogleMap(
                    cameraTargetBounds: CameraTargetBounds(
                      // bound camera so user can't spoof location.
                      LatLngBounds(
                        southwest: LatLng(
                          _currentPosition!.latitude - 0.008,
                          _currentPosition!.longitude - 0.008,
                        ),
                        northeast: LatLng(
                          _currentPosition!.latitude + 0.008,
                          _currentPosition!.longitude + 0.008,
                        ),
                      ),
                    ),
                    compassEnabled: false,
                    zoomGesturesEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: cameraPosition,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      controller.setMapStyle(_mapStyle);
                    },
                    onCameraMoveStarted: () {
                      mapPickerController.mapMoving!();
                      setState(() {
                        addressStatus = "Finding your location...";
                      });
                    },
                    onCameraMove: (cameraPosition) {
                      this.cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () async {
                      // notify map stopped moving
                      mapPickerController.mapFinishedMoving!();
                      //get address name from camera position
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                        cameraPosition.target.latitude,
                        cameraPosition.target.longitude,
                      );

                      finalLocation = placemarks;
                      updateAddress(placemarks);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  addressStatus,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Modern-Era',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
