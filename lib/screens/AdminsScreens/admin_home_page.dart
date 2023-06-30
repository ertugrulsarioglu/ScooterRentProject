import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scooter_app/screens/AdminsScreens/admin_profile_page.dart';
import 'package:scooter_app/screens/AdminsScreens/admin_scooter_page.dart';
import 'package:scooter_app/screens/AdminsScreens/admin_users_page.dart';
import 'package:scooter_app/screens/login_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late GoogleMapController _mapController;
  final LatLng _center = const LatLng(39.90542443068985, 41.26579858957866);
  Map<String, Marker> _markers = {};
  // _onMapCreated(GoogleMapController controller) {}

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // Geri düğmesine basıldığında işlem yapmak için burayı kullanabilirsiniz
        // true döndürerek geri gitmeyi engelleyebilirsiniz
        return false;
      },
      child: Scaffold(
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
              myLocationButtonEnabled: true,
              myLocationEnabled: false,
              indoorViewEnabled: true,
              trafficEnabled: true,
              zoomControlsEnabled: false,
              minMaxZoomPreference: const MinMaxZoomPreference(8, 15),
            ),
            Positioned(
              bottom: 10,
              left: 110,
              right: 110,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 1),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminScooterPage()));
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.electric_scooter_outlined,
                          color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Scooterlar",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                    backgroundColor: const Color(0xff31274F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                    MaterialPageRoute(
                        builder: (context) => const AdminProfilePage()),
                  );
                } else if (choice == 'exit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else if (choice == 'users') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminUsersPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Profil'),
                ),
                const PopupMenuItem<String>(
                  value: 'users',
                  child: Text('Kullanıcılar'),
                ),
                const PopupMenuItem<String>(
                  value: 'exit',
                  child: Text('Çıkış Yap'),
                ),
              ],
            ),
          ],
        ),
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
      infoWindow: InfoWindow(
        title: "Argekip Scooters",
        snippet: "Kiralamak için tıklayınız.",
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            builder: (BuildContext context) {
              return Container(
                height: 1000,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                  color: Color(0xff21254A),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 500,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.0),
                          ),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/scooterBottomSheet.png'),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Kiralama ücreti kullanım sürenizle ilgilidir.\nSaati 10₺\nTam kapasite menzil: 15Km',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        showBarcodeScanner();
                      },
                      child: Text(
                        "KİRALA",
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        backgroundColor: const Color(0xFF713cd0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        },
      ),
      icon: markerIcon,
    );
    _markers[id] = marker;
    setState(() {});
  }

  onBarcodeScan(String barcodeScanRes) {
    if (barcodeScanRes != "-1") {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("QR Kodu"),
          content: Text(barcodeScanRes),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tamam"),
            ),
          ],
        ),
      );
    }
  }

  Future<void> showBarcodeScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Vazgeç", true, ScanMode.QR);
    onBarcodeScan(barcodeScanRes);
  }
}
