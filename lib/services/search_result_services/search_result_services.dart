import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SearchResultsService {
  Future<List<Map<String, dynamic>>> searchProfiles(
      RangeValues ageRange, double distance, double weight) async {
    final firestore = FirebaseFirestore.instance;
    final userLocation = await _getCurrentLocation();
    if (userLocation == null) {
      return [];
    }

    final query = firestore
        .collection('users')
        .where('age',
            isGreaterThanOrEqualTo: ageRange.start,
            isLessThanOrEqualTo: ageRange.end)
        .get();

    final querySnapshot = await query;
    final filteredDocs = querySnapshot.docs.where((doc) {
      final data = doc.data() as Map<String, dynamic>;

      // Ensure the document contains the required fields
      if (!data.containsKey('location') || !data.containsKey('weight')) {
        return false;
      }

      final GeoPoint profileLocation = data['location'];
      final distanceInKm = _calculateDistance(
        userLocation.latitude!,
        userLocation.longitude!,
        profileLocation.latitude,
        profileLocation.longitude,
      );

      // Filter by distance and weight
      return distanceInKm <= distance && (data['weight'] as num) <= weight;
    }).toList();

    return filteredDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final GeoPoint profileLocation = data['location'];
      final distanceInKm = _calculateDistance(
        userLocation.latitude!,
        userLocation.longitude!,
        profileLocation.latitude,
        profileLocation.longitude,
      );
      return {
        ...data,
        'distance': distanceInKm.toStringAsFixed(2),
      };
    }).toList();
  }

  Future<LocationData?> _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  double _calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    var earthRadiusKm = 6371;

    double dLat = _degreesToRadians(endLatitude - startLatitude);
    double dLon = _degreesToRadians(endLongitude - startLongitude);

    double lat1 = _degreesToRadians(startLatitude);
    double lat2 = _degreesToRadians(endLatitude);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusKm * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
