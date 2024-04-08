import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:smart_delivery/flexible_polyline.dart';
import 'package:smart_delivery/latlngz.dart';


class RouteMap extends StatefulWidget {
  const RouteMap({super.key});

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HERE Map Example')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            print(snapshot.data);
            var route =
            snapshot.data!['routes'][0]['sections'][0]['polyline'];
            var startMarker = snapshot.data!['routes'][0]['sections'][0]
            ['departure']['place']['location'];
            var endMarker = snapshot.data!['routes'][0]['sections'][0]
            ['arrival']['place']['location'];
            // print(startMarker[0] + "  " + endMarker[0]);

            return Stack(children: [
              Positioned.fill(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(startMarker['lat'] as double,
                        startMarker['lng'] as double),
                    zoom: 5.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      // subdomains: ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      //12.7889551, 80.2213335
                      // 12.791826579973867, 80.22216117610574
                      //12.79699690468084, 80.22307579398407
                      // 12.8593407,  80.2265026
                      polylines: [
                        Polyline(
                          points: [
                            LatLng(12.7889551, 80.2213335),
                            LatLng(12.791826579973867, 80.22216117610574),
                            LatLng(12.79699690468084, 80.22307579398407),
                            LatLng(12.8593407, 80.2265026)
                          ],
                          color: Colors.blue,
                          strokeWidth: 3.0,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 40.0,
                          height: 40.0,
                          point:
                          LatLng(startMarker['lat'], startMarker['lng']),
                          child: Icon(Icons.location_on, color: Colors.green),
                        ),
                        Marker(
                          width: 40.0,
                          height: 40.0,
                          point: LatLng(endMarker['lat'], endMarker['lng']),
                          child: Icon(Icons.location_on, color: Colors.red),
                        ),
                      ],
                    )
                  ],
                  // layers: [
                  //   TileLayerOptions(
                  //     urlTemplate:
                  //         'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //     subdomains: ['a', 'b', 'c'],
                  //   ),
                  //   PolylineLayerOptions(
                  //     polylines: [
                  //       Polyline(
                  //         points: decodePolyline(route),
                  //         color: Colors.blue,
                  //         strokeWidth: 3.0,
                  //       ),
                  //     ],
                  //   ),
                  //   MarkerLayerOptions(
                  //     markers: [
                  //       Marker(
                  //         width: 40.0,
                  //         height: 40.0,
                  //         point: LatLng(startMarker[0], startMarker[1]),
                  //         builder: (ctx) =>
                  //             Icon(Icons.location_on, color: Colors.green),
                  //       ),
                  //       Marker(
                  //         width: 40.0,
                  //         height: 40.0,
                  //         point: LatLng(endMarker[0], endMarker[1]),
                  //         builder: (ctx) =>
                  //             Icon(Icons.location_on, color: Colors.red),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.all(5),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 243, 243, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black87,
                      ),
                      hintText: 'Search you\'re looking for',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
  Future<Map<String, dynamic>> _getRoute() async {
    final apiKey = 'd_ag3Uo2tkXDKu4yXHAHMX5L-YsiYlhswXAYd6M6fUo';
    final url = Uri.parse(
        'https://router.hereapi.com/v8/routes?transportMode=car&origin=12.788984785298272,80.22124499381923&destination=12.859312691685638,80.2266953129383&return=polyline&app_id=lGbbK0FdH3y7Qu4ZaZIU&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load route: ${response.statusCode}');
    }
  }

  List<LatLng> decodePolyline(String polyline) {
    if (polyline == null || polyline.isEmpty) {
      return [];
    }

    List<LatLng> decoded = [];
    int index = 0;
    int lat = 0;
    int lng = 0;

    while (index < polyline.length) {
      int shift = 0;
      int result = 0;
      int byte;

      do {
        byte = polyline.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        byte = polyline.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latitude = lat / 1E5;
      double longitude = lng / 1E5;

      if (latitude >= -90 &&
          latitude <= 90 &&
          longitude >= -180 &&
          longitude <= 180) {
        decoded.add(LatLng(latitude, longitude));
      } else {
        print('Invalid latitude/longitude: $latitude, $longitude');
      }
    }

    return decoded;
  }

  List<LatLngZ> decode_with_polyline(String encoded) {
    List<LatLngZ> decoded = FlexiblePolyline.decode("BFoz5xJ67i1B1B7PzIhaxL7Y");
    print(decoded);
    return decoded;
  }

  List<PointLatLng> decodeEncodedPolyline(String encoded) {
    List<PointLatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      PointLatLng p =
      new PointLatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

/// Note instead of using the class,
/// you can use Google LatLng() by importing it from their library.

// List<LatLng> decodePolyline(String polyline) {
//   List<LatLng> decoded = [];
//   var index = 0;
//   var lat = 0;
//   var lng = 0;

//   while (index < polyline.length) {
//     var b;
//     var shift = 0;
//     var result = 0;
//     do {
//       b = polyline.codeUnitAt(index++) - 63;
//       result |= (b & 0x1F) << shift;
//       shift += 5;
//     } while (b >= 0x20);
//     var dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//     lat += dlat;

//     shift = 0;
//     result = 0;
//     do {
//       b = polyline.codeUnitAt(index++) - 63;
//       result |= (b & 0x1F) << shift;
//       shift += 5;
//     } while (b >= 0x20);
//     var dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//     lng += dlng;

//     var latitude = lat / 1E5;
//     var longitude = lng / 1E5;
//     if (latitude >= -90 &&
//         latitude <= 90 &&
//         longitude >= -180 &&
//         longitude <= 180) {
//       decoded.add(LatLng(latitude, longitude));
//     }
//   }

//   return decoded;
// }
}

