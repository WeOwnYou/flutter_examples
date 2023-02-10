import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../reverse_geocode.dart';
import '../reverse_geocode_service/geocode_service.dart';

class MainScreenVM extends ChangeNotifier {
  double _latitude = -1;
  double _longitude = -1;
  String _address = '';

  double get longitude => _longitude;
  double get latitude => _latitude;
  String get address => _address;

  MainScreenVM() {
    onGetAddressesTap();
  }

  onGetAddressesTap() async {
    await _getCoordinates();
    final allData =
        (await GeocodeService().getAddress(lon: _longitude, lat: _latitude))
                .suggestions ??
            [Suggestions()];
    if(allData.isNotEmpty) {
      _address = allData.first.value ?? 'Not an address';
    }else{
      _address = 'Lost';
    }
    notifyListeners();
  }

  _getCoordinates() async {
    final Position position = (await _determinePosition());
    _longitude = position.longitude;
    _latitude = position.latitude;
    notifyListeners();
    // const LocationSettings locationSettings = LocationSettings(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: 100,
    // );
    // StreamSubscription<Position> positionStream =
    //     Geolocator.getPositionStream(locationSettings: locationSettings)
    //         .listen((Position? position) {
    //           if(position != null){
    //             _longitude = position.longitude;
    //             _latitude = position.latitude;
    //             print('$_latitude, $_longitude');
    //             notifyListeners();
    //           }
    //     });
  }

  Future<Position> _determinePosition() async {
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
    // print( await Geolocator.getCurrentPosition());
    return await Geolocator.getCurrentPosition();
  }
}
