// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dart_geohash/dart_geohash.dart';
// import 'package:dartz/dartz.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:a_box_customer_app/constant/map_constant.dart';
// import 'package:a_box_customer_app/models/location/location_model.dart';
// import 'package:a_box_customer_app/service_locator/service_locator.dart';
// import 'package:a_box_customer_app/services/auth_service.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart';

// class LocationService {
//   final FirebaseDatabase firebaseDatabase = locator<FirebaseDatabase>();
//   final AuthService authService = locator<AuthService>();

//   Future<LocationModel> getPlaceDetails(
//     String placeId,
//   ) async {
//     String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
//     String request = '$baseURL?place_id=$placeId&key=$GOOGLE_MAP_API_KEY';
//     var response = await http.get(Uri.tryParse(request)!);
//     try {
//       if (response.statusCode == 200) {
//         final placeDetails = json.decode(response.body);
//         final location = placeDetails['result']['geometry']['location'];
//         final formattedAddress = placeDetails['result']["formatted_address"];

//         return LocationModel(
//           latitude: location['lat'],
//           longitude: location['lng'],
//           placeId: placeId,
//           name: formattedAddress,
//           geoHash: getGeoHash(location['lat'], location['lng']),
//         );
//       } else {
//         // throw Exception('Failed to load place details');
//         return LocationModel.empty;
//       }
//     } catch (e) {
//       // print('Error: $e');
//       return LocationModel.empty;
//     }
//   }

//   String getGeoHash(double latitude, double longitude) {
//     var geoHasher = GeoHasher();

//     final geoHash = geoHasher.encode(longitude, latitude);

//     // GeoHash myOtherHash = GeoHash.fromDecimalDegrees(-98.1235, 38.1234);

//     return geoHash;
//   }

//   // Stream<LocationData>? get locationStream => _locationStream;
//   Future<void> getLocationData() async {
//     Location location = Location();

//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//     try {
//       LocationData locationData = await location.getLocation();

//       locator<FirebaseFirestore>()
//           .collection('users')
//           .doc(locator<FirebaseAuth>().currentUser!.uid)
//           .update(
//         {
//           'latitude': locationData.latitude,
//           'longitude': locationData.longitude,
//         },
//       );
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String> fetchRoutePolyline(
//       String startLocation, String endLocation) async {
//     final String directionsUrl =
//         'https://maps.googleapis.com/maps/api/directions/json?'
//         'origin=$startLocation&'
//         'destination=$endLocation&'
//         'key=$GOOGLE_MAP_API_KEY';

//     final response = await http.get(Uri.parse(directionsUrl));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final polyline = data['routes'][0]['overview_polyline']['points'];
//       return polyline;
//     } else {
//       throw Exception('Failed to load directions');
//     }
//   }

//   List<LatLng> decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1f) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       LatLng p = LatLng(lat / 1E5, lng / 1E5);
//       points.add(p);
//     }
//     return points;
//   }

//   Future<LatLng> getCurrentUserLocation() async {
//     Location location = Location();
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//     LocationData locationData;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         throw Exception('Location services are disabled.');
//       }
//     }

//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         throw Exception('Location permissions are denied');
//       }
//     }

//     locationData = await location.getLocation();
//     return LatLng(locationData.latitude!, locationData.longitude!);
//   }

//   Future<Tuple2<double, String>> getDistanceBetweenTwoLocations(
//       double startLat, double startLng, double endLat, double endLng) async {
//     const apiKey = GOOGLE_MAP_API_KEY;
//     final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$startLat,$startLng&destinations=$endLat,$endLng&key=$apiKey',
//     );

//     try {
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final distanceInMeters =
//             data['rows'][0]['elements'][0]['distance']['value'];
//         final kmDistance =
//             distanceInMeters / 1000; // Convert meters to kilometers

//         final distanceText = data['rows'][0]['elements'][0]['distance']['text'];

//         return tuple2(kmDistance, distanceText);
//       } else {
//         // throw Exception('Failed to fetch distance');
//         return tuple2(-1, "");
//       }
//     } catch (e) {
//       return tuple2(-1, ""); //todo update this function in a better way
//     }
//   }
// }
