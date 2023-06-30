import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scooter_app/screens/login_page.dart';
import 'package:scooter_app/screens/profile_page.dart';
import 'package:scooter_app/screens/register_page.dart';
import 'package:scooter_app/screens/rent_page.dart';
import 'package:scooter_app/screens/scooter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(39.90542443068985, 41.26579858957866);
  Map<String, Marker> _markers = {};
  _onMapCreated(GoogleMapController controller) {
    setState(() {
      // _markers.addAll([
      //   Marker(
      //     markerId: MarkerId("markerXiaomi"),
      //     draggable: true,
      //     position: _center,
      //     onTap: () {
      //       print("Marker tıklandı");
      //     },
      //     infoWindow: InfoWindow(
      //       title: "Xiaomi elektrikli scooter",
      //       snippet: "şarj durumu %80",
      //       onTap: () {
      //         print("info modal tıklandı");
      //       },
      //     ),
      //     icon: BitmapDescriptor.defaultMarker,
      //   ),
      // ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onTap: (latLng) {
              print(latLng);
            },
            onLongPress: (latLng) {
              print(LatLng);
            },
            onCameraMove: (cp) {
              print(cp);
            },
            markers: _markers.values.toSet(),
            onCameraMoveStarted: () {
              print("Başladı");
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              addMarker('Xiaomi elektrikli Scooter', _center);
            },
            //myLocationButtonEnabled: true,
            myLocationEnabled: false,
            indoorViewEnabled: true,
            trafficEnabled: true,
            zoomControlsEnabled: false,
            minMaxZoomPreference: const MinMaxZoomPreference(8, 15),
          ),
          Positioned(
            bottom: 10,
            left: 100,
            right: 100,
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.electric_scooter_outlined, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Scooterlar",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScooterPage()));
                });
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                backgroundColor: const Color(0xff31274F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 152),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       _mapController.animateCamera(
      //           CameraUpdate.newCameraPosition(const CameraPosition(
      //         target: LatLng(41.169229107386606, 40.8930191645931),
      //         zoom: 13,
      //       )));
      //     },
      //     tooltip: 'Increment',
      //     child: Icon(Icons.electric_scooter_outlined),
      //     backgroundColor: const Color(0xff31274F),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF713cd0),
        title: const Text('Harita'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (choice) {
              // seçilen öğeye göre işlem yap
              if (choice == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              } else if (choice == 'exit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('Profil'),
              ),
              const PopupMenuItem<String>(
                value: 'exit',
                child: Text('Çıkış Yap'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  addMarker(String id, LatLng location) async {
    var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      'assets/images/markerScooter.png',
    );
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'Xiaomi Elektrikli Scooter',
        snippet: 'Şarj Durumu = %80',
      ),
      icon: markerIcon,
    );
    _markers[id] = marker;
    setState(() {});
  }
}
