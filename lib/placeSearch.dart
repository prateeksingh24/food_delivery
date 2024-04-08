import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceSearchPage extends StatefulWidget {
  const PlaceSearchPage({super.key});

  @override
  State<PlaceSearchPage> createState() => _PlaceSearchPageState();
}

class _PlaceSearchPageState extends State<PlaceSearchPage> {

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _searchPlace(String query) async {
    final String apiKey = 'd_ag3Uo2tkXDKu4yXHAHMX5L-YsiYlhswXAYd6M6fUo';
    final String baseUrl =
        'https://discover.search.hereapi.com/v1/discover?at=25.05230661095756,75.8282113815214&limit=2&q=IIIT+Kota&apiKey=$apiKey';
    final String altUrl = "https://geocode.search.hereapi.com/v1/geocode?q=City+Mall&apiKey=$apiKey";
    final response = await http.get(Uri.parse(altUrl));
    final data = jsonDecode(response.body);
    print(data);
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   print(data);
    //   // final lat = data['location']['lat'];
    //   // final lon = data['location']['lng'];
    //   // print('Latitude: $lat, Longitude: $lon');
    // } else {
    //   print('Failed to get live location: ${response.statusCode}');
    // }


    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      setState(() {
        _searchResults = items.map<Map<String, dynamic>>((item) {
          return {
            'title': item['title'],
            'address': {
              'label': item['address']['label'],
              'countryCode': item['address']['countryCode'],
              // Example: Include additional data if needed
              // Add more fields as needed
            },
            'position': {
              'lat': item['position']['lat'],
              'lng': item['position']['lng'],
            },
            // Add more fields as needed
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Place Search'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a place',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchPlace(_searchController.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, dynamic> place = _searchResults[index];
                  return ListTile(
                    title: Text(place['title'] ?? 'Unknown Title'),
                    // subtitle: Text(place['address']['label'] ?? 'Unknown Address'),
                    subtitle: Text("Lat : " + place['position']['lat'].toString()+" Long : "+place['position']['lng'].toString()),

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
