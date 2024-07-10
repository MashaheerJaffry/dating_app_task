// user_preferences_service.dart

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  Future<void> getLocationAndSaveToFirebase(
      String username, String birthday, String gender) async {
    // Initialize the location plugin
    Location location = Location();

    // Check if location services are enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    // Check for location permissions
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied.');
      }
    }

    // Get the current location
    LocationData locationData = await location.getLocation();
    SharedPreferences sp = await SharedPreferences.getInstance();
    final uid = sp.getString('uid');
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('users').doc(uid).update({
      'location': GeoPoint(locationData.latitude!, locationData.longitude!),
      'username': username,
      'birthday': birthday,
      'gender': gender,
      'age': _getRandomNumber(),
      'weight': _getRandomNumber(),
    });
  }

  int _getRandomNumber() {
    Random random = Random();
    int min = 20;
    int max = 60;
    return min + random.nextInt(max - min + 1);
  }
}
