import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../controllers/home_controller.dart';
import 'base_page.dart';

class MapsPage extends StatelessWidget {
  final HomeController controller;

  MapsPage(this.controller);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      bodyContent: MapWidget(),
      selectedIndex: 0,
      controller: controller,
    );
  }
}

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final LatLng _initialPosition = LatLng(-6.284020, 106.530545);
  List<Marker> _poiMarkers = [];

  @override
  void initState() {
    super.initState();
    _fetchNearbyLocations(_initialPosition);
  }

  // Fungsi untuk mengambil data POI dari Overpass API
  Future<void> _fetchNearbyLocations(LatLng center) async {
    final overpassUrl = "https://overpass-api.de/api/interpreter";
    final query = """
      [out:json];
      (
        node(around:1000,${center.latitude},${center.longitude})[amenity=school];
        node(around:1000,${center.latitude},${center.longitude})[amenity=townhall];
        node(around:1000,${center.latitude},${center.longitude})[amenity=hospital];
        node(around:1000,${center.latitude},${center.longitude})[amenity=restaurant];
        node(around:1000,${center.latitude},${center.longitude})[amenity=police];
        node(around:1000,${center.latitude},${center.longitude})[amenity=bank];
        node(around:1000,${center.latitude},${center.longitude})[amenity=post_office];
      );
      out body;
    """;

    try {
      final response = await http.post(
        Uri.parse(overpassUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Marker> markers = [];

        for (var element in data['elements']) {
          final lat = element['lat'];
          final lon = element['lon'];
          final name = element['tags']?['name'] ?? 'Tempat Tanpa Nama';
          final amenity = element['tags']?['amenity'] ?? 'Tidak Diketahui';

          markers.add(
            Marker(
              point: LatLng(lat, lon),
              width: 80.0,
              height: 80.0,
              builder: (ctx) => GestureDetector(
                onTap: () => _showLocationDetails(context, name, amenity),
                child: Icon(
                  Icons.location_on,
                  color: _getColorForAmenity(amenity),
                  size: 30.0,
                ),
              ),
            ),
          );
        }

        setState(() {
          _poiMarkers = markers;
        });
      } else {
        throw Exception("Gagal mengambil data POI");
      }
    } catch (e) {
      print("Error mengambil data POI: $e");
    }
  }

  // Fungsi untuk mengatur warna marker berdasarkan jenis amenity
  Color _getColorForAmenity(String amenity) {
    switch (amenity) {
      case 'school':
        return Colors.blue;
      case 'townhall':
        return Colors.red;
      case 'hospital':
        return Colors.green;
      case 'restaurant':
        return Colors.orange;
      case 'police':
        return Colors.purple;
      case 'bank':
        return Colors.yellow;
      case 'post_office':
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  // Fungsi untuk menampilkan detail lokasi
  void _showLocationDetails(BuildContext context, String name, String amenity) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
          content: Text('Jenis: $amenity'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: _initialPosition,
        zoom: 18.0, // Set zoom level agar area radius 1000 meter lebih terlihat
        maxZoom: 20.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: _poiMarkers, // Menampilkan semua POI sebagai marker
        ),
      ],
    );
  }
}
